module EcData
    class OrderProduct < EcData::Base
        belongs_to :stock, class_name:"Stock"
        belongs_to :product, class_name:"EcData::Product"
        belongs_to :order_list, class_name:"EcData:OrderList"
    end
end
