class FewItemBoxesController < ApplicationController
    def update
        @stock = Stock.find(params[:id])
        @stock.update_attributes(stock_params)
        redirect_to stocks_path
    end

    def edit
        @stock = Stock.find(params[:id])
        if @stock.shipment_week
    end
    private
    def stock_params
        params.require(:few_item_box).permit(:type,:quantity,:shipment_week,:remark)
    end

end
