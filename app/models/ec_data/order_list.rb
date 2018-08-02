module EcData
    class OrderList < EcData::Base
        belongs_to :user, class_name:"EcData::Payment", optional: true
        has_one :sending_address, class_name:"EcData::Sending_address"
        has_one :payment, class_name:"EcData::Payment", dependent: :destroy
        has_many :products, class_name:"EcData::Product", through: :order_products
        has_many :order_products, class_name:"EcData::OrderProduct"
    end
end
