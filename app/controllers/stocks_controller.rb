class StocksController < ApplicationController
    include StocksHelper
    def index
        @stocks = current_user.stocks
    end

    def new
        @stock = current_user.stocks.build
        @list = calcurate_week_day
    end

    def create
        @stock = current_user.stocks.build(stock_params)
        @stock.calculate_lock_date
        @stock.save
        redirect_to stocks_path
    end

    def show
        @stock = Stock.find(params[:id])
    end

    def update
        @stock = Stock.find(params[:id])
        @stock.update_attributes(stock_params)
        redirect_to stocks_path
    end

    def edit
        @stock = Stock.find(params[:id])
    end

    def destroy
    end

    private
    def stock_params
        params.require(:stock).permit(:type,:quantity,:shipment_week,:remark)
    end

end
