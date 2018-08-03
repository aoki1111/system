module EcData
    class OrderProduct < EcData::Base
        belongs_to :stock, class_name:"Stock"
    end
end
