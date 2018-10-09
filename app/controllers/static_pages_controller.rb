class StaticPagesController < ApplicationController
    before_action :logged_in_user, only: [:dashboard]
    require 'date'

    def home
    end

    def help
    end

    def company
    end

    def privacy
    end

    def introducing
    end

    def dashboard
        stock_ids = Stock.where(user_id:current_user.id).pluck(:id) 
        @dashboard_order = EcData::OrderProduct.eager_load(:order_list, :product, {order_list: :payment},{order_list: :buyer_address}, {order_list: :sending_address}).where(stock_id:stock_ids).where(trailing_id:nil).where(:order_list => {:payments => {paid: true}}).order("order_products.created_at DESC")
    end

    def shipments
    end

    def record
    end

    def gap
    end

end
