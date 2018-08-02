module EcData
    class Product < EcData::Base
        self.primary_key = "id"
        has_many :order_lists, through: :order_products
        has_many :order_products
        has_many :product_images
    end
end
