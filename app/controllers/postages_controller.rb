class PostagesController < ApplicationController
    before_action :logged_in_user
    include PostagesHelper

    def index
        @postages = current_user.postages
    end

    def new
        @postage = Postage.new
        @postage_list = postage_list
    end

    def create
        @postage = current_user.postages.build(postage_params)
        if @postage.save
            redirect_to dashboard_path, flash: { success: "送料の設定が完了しました。"}
        else
            render 'new'
        end
    end

    def edit
        @postage = Postage.find(params[:id])
        @postage_list = postage_list
    end

    def update
        @postage = Postage.find(params[:id])
        if @postage.update_attributes(postage_params)
            redirect_to postage_path(@postage)
        else
            render 'edit'
        end
    end

    def show
        @postage = Postage.find(params[:id])
    end

    def delete
        @postage = Postage.find(params[:id])
        if @postage.destroy
            redirect_to dashboard_path
        else
            redirect_to postage_path(@postage)
        end
    end
    private

    def postage_params
        params.require(:postage).permit(:area,:item_type,:company,:hokkaido,:touhoku,:kitatouhoku,:minamitouhoku,:kantou,:tokyo,:hokuriku,:shinetsu,:chubu,:kansai,:chugoku,:shikoku,:kyushu,:kitakyushu,:minamikyushu,:okinawa)
    end
end
