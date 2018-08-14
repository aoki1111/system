module EcData
    class OrderList < EcData::Base
      self.primary_key = "id"
      has_one :buyer_address
      has_one :sending_address
      has_one :payment, class_name: "EcData::Payment"
    end
end
