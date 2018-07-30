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
        @stock.save
        redirect_to stocks_path
    end

    def show
    end

    def update
    end

    def edit
    end

    def destroy
    end

    private
    def stock_params
        params.require(:stock).permit(:type,:quantity,:shipment_week,:remark)
    end
end
