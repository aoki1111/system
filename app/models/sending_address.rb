class SendingAddress < EcData::Address
  self.primary_key = "id"
  belongs_to :order_list, class_name:"EcData::OrderList"
end
