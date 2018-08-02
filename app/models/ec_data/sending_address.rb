module EcData
    class SendingAddress < EcData::Base
        self.primary_key = "id"
        belongs_to :user, class_name:"EcData::User", optional: true
        belongs_to :order_list,class_name:"EcData::OrderList", optional: true
    end
end
