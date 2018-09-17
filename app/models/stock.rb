class Stock < ApplicationRecord
    attr_accessor :select_type
    belongs_to :user
    belongs_to :product, class_name:"EcData::Product"
    has_many :order_products, class_name:"EcData::OrderProduct"
    validates :shipment_week, presence: true
    validates :quantity, presence: true

    def calculate_sales_start
        first_day = Date.today.beginning_of_year
        path_day = self.shipment_week * 7
        week_day = first_day + path_day - first_day.cwday + 1 - 7
        self.salable = week_day
    end
end
