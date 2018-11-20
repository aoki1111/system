class ProductItem < ApplicationRecord
    belongs_to :user
    belongs_to :product, class_name:"EcData::Product"
end
