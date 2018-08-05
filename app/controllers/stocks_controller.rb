class StocksController < ApplicationController
    include StocksHelper
    def index
        @stocks = current_user.stocks
    end

    def new
        @stock = current_user.stocks.build
        @week_list = calcurate_week_day
        @stock_list = stock_list
    end

    def create
        @week_list = calcurate_week_day
        @stock_list = stock_list
        @stock = current_user.stocks.build(stock_params)
        @stock.calculate_sales_start
        if @stock.save
            if @stock.salable < Time.zone.now
                product = EcData::Product.find_by(class_name:@stock.type)
                if product.stocks.nil?
                    product.stocks = @stock.quantity
                else
                    product.stocks += @stock.quantity
                end
                product.save
                redirect_to stocks_path, flash: { success: "ECサイトへの在庫の登録が完了しました。"}
            else
                redirect_to stocks_path, flash: { success: "在庫の登録が完了しました。毎週月曜日にECサイトに在庫は紐付けされます。"}
            end
        else
            render 'new'
        end
    end

    def show
        @stock = Stock.find(params[:id])
    end

    def update
        @week_list = calcurate_week_day
        @stock_list = stock_list
        @stock = Stock.find(params[:id])
        if @stock.update_attributes(stock_params)
            redirect_to stocks_path, flash: { success: "出荷予定の編集が完了しました"}
        else
            flash[:danger] = "出荷予定の編集に失敗しました。"
            render 'edit'
        end
    end

    def edit
        @week_list = calcurate_week_day
        @stock_list = stock_list
        @stock = Stock.find(params[:id])
    end

    def destroy
    end

    def complete
        order = EcData::OrderProduct.find_by(id:params[:order_id])
        order.trailing_id = params[:trailing_id]
        if order.save
            order_list = EcData::OrderList.find_by(id:order.order_list_id)
            buyer_address = order_list.buyer_address
            sending_address = order_list.sending_address unless buyer_address.same_sending_address
            product = EcData::Product.find_by(id:order.product_id)
            postage = current_user.postages.find_by(item_type:product.class_name)
            OrderMailer.shipment_notification(order:order,buyer_address:buyer_address,sending_address:sending_address ,product:product,postage:postage)
            redirect_to dashboard_path, flash: { success: "出荷完了報告が正常に行われました。"}
        else
            redirect_to dashboard_path, flash: { success: "出荷完了報告でエラーが発生しました。管理者に連絡してください。"}
        end
    end

    private
    def stock_params
        params.require(:stock).permit(:pref,:area,:type,:box_flag,:quantity,:shipment_week,:remark)
    end

end
