class MiddleBoxesController < ApplicationController

    def update
        @stock = Stock.find(params[:id])
        if @stock.update_attributes(stock_params)
            redirect_to stocks_path, flash: { success: "出荷予定の編集が完了しました"}
        else
            flash[:danger] = "出荷予定の編集に失敗しました。"
            render 'edit'
        end
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
