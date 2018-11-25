module EcData
    class OrderList < EcData::Base
      self.primary_key = "id"
      has_one :buyer_address, dependent: :destroy
      has_one :sending_address, dependent: :destroy
      has_one :payment, class_name: "EcData::Payment", dependent: :destroy
      has_many :order_products, class_name:"EcData::OrderProduct", dependent: :destroy
    end
end
