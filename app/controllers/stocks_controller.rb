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
        @stock = current_user.stocks.build(stock_params)
        @stock.calculate_sales_start
        @stock.save
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
    end

    def show
        @stock = Stock.find(params[:id])
    end

    def update
        @stock = Stock.find(params[:id])
        @stock.update_attributes(stock_params)
        update_product_stocks(params[:type])
        redirect_to stocks_path
    end

    def edit
        @stock = Stock.find(params[:id])
    end

    def destroy
    end

    def complete
        order = EcData::OrderProduct.find_by(id:params[:order_id])
        order.trailing_id = params[:trailing_id]
        order.save
        redirect_to dashboard_path
    end

    private
    def stock_params
        params.require(:stock).permit(:pref,:area,:type,:box_flag,:quantity,:shipment_week,:remark)
    end

end
