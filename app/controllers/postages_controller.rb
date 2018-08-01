class PostagesController < ApplicationController

    def index
        @postages = current_user.postages
    end

    def new
        @postage = Postage.new
    end

    def create
        @postage = current_user.postages.build(postage_params)
        @postage.save
        redirect_to dashboard_path
    end

    def edit
        @postage = Postage.find(params[:id])
    end

    def update
        @postage = Postage.find(params[:id])
        @postage.update_attributes(postage_params)
        redirect_to postage_path(@postage)
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
