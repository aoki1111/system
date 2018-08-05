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
         unless @week_stock.nil?
            orders = @week_stock.order_products
            @caution_orders = orders.where("bought_time < ?", Time.zone.now - 2.day)
            @normal_orders = orders.where.not("bought_time < ?", Time.zone.now - 2.day)
        end
    end

    def shipments
    end

    def record
    end

    def gap
    end

end
