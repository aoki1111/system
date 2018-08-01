class MiddleBoxesController < ApplicationController

    def update
        @stock = Stock.find(params[:id])
        @stock.update_attributes(stock_params)
        redirect_to stocks_path
    end

    def edit
        @stock = Stock.find(params[:id])
        if @stock.salable > Time.zone.now
            redirect_to stocks_path
        else
            render 'edit'
        end
    end
    private
    def stock_params
        params.require(:middle_box).permit(:type,:quantity,:shipment_week,:remark)
    end

end
