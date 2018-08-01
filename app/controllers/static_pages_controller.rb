class StaticPagesController < ApplicationController
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
        @week_stock = current_user.stocks.find_by(salable:Time.zone.now.beginning_of_week)
        @orders = @week_stock.order_products unless @week_stock.nil?
    end

    def shipments
    end

    def record
    end

    def gap
    end

end
