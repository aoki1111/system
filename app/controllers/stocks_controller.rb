class StocksController < ApplicationController
    before_action :logged_in_user
    include StocksHelper
    def index
        @stocks = current_user.stocks.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    end

    def new
        @stock = current_user.stocks.build
        @week_list = calcurate_week_day
        @product_list = product_list
    end

    def create
        @week_list = calcurate_week_day
        @product_list = product_list
        @stock = current_user.stocks.build(stock_params)
        @stock.calculate_sales_start
        begin
            @stock.save
        rescue => e
            logger.error(e)
            redirect_to new_stock_path, flash: {danger: "指定した出荷情報は作成済みです。編集から修正をかけてください。"}
        else
            if @stock.salable < Time.zone.now
                product = EcData::Product.find(@stock.product_id)
                if product.stock_counts.nil?
                    product.stock_counts = @stock.quantity
                else
                    product.update_attributes(stock_counts:Stock.where(salable:@stock.salable).sum(:quantity))
                end
                redirect_to stocks_path, flash: { success: "ECサイトへの在庫の登録が完了しました。"}
            else
                redirect_to stocks_path, flash: { success: "在庫の登録が完了しました。毎週月曜日にECサイトに在庫は紐付けされます。"}
            end
        end
    end

    def show
        @stock = Stock.find(params[:id])
        @orders = @stock.order_products
    end

    def update
        @week_list = calcurate_week_day
        @product_list = product_list
        @stock = Stock.find(params[:id])
        if @stock.update_attributes(stock_params)
            if @stock.salable == Time.zone.now.beginning_of_week
                EcData::Product.find(@stock.product_id).update_attributes(stock_counts:Stock.where(salable:@stock.salable).sum(:quantity))
            end
            redirect_to stocks_path, flash: { success: "出荷予定の編集が完了しました"}
        else
            flash[:danger] = "出荷予定の編集に失敗しました。"
            render 'edit'
        end
    end

    def edit
        @week_list = calcurate_week_day
        @product_list = product_list
        @stock = Stock.find(params[:id])
    end

    def destroy
    end

    def complete
        order = EcData::OrderProduct.find_by(id:params[:order_id])
        order.trailing_id = params[:trailing_id]
        if order.save
            order.send_shipment_complete(current_user)
            redirect_to dashboard_path, flash: { success: "出荷完了報告が正常に行われました。"}
        else
            redirect_to dashboard_path, flash: { success: "出荷完了報告でエラーが発生しました。管理者に連絡してください。"}
        end
    end

    private
    def stock_params
        params.require(:stock).permit(:pref,:area,:product_id,:quantity,:shipment_week,:remark)
    end

end
