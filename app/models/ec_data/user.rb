module EcData
    class User < EcData::Base
        self.primary_key = "id"
        has_many :order_lists, class_name:"EcData::OrderList" ,dependent: :destroy
        has_many :sending_addresses,class_name:"EcData::SendingAddress"
        has_many :purchases, class_name:"Purchase"
    end
end
