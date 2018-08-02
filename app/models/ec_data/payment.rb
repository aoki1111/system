module EcData
    class Payment < EcData::Base
        belongs_to :order_list, class_name:"EcData::OrderList"
    end
end
