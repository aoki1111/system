class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def product_list
        list = EcData::Product.where(id:current_user.product_items.pluck(:product_id)).pluck(:name,:id)
        return list
    end

    private
    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "ログインをしてください。"
            redirect_to login_path
        end
    end

end
