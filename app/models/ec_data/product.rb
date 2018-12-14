module EcData
  class Product < EcData::Base
    has_many :order_lists, through: :order_products
    has_many :order_products
    has_many :stocks, foreign_key:"product_id"
    has_many :product_items, class_name:"::ProductItem" ,foreign_key:"product_id"
    has_many :users, class_name:"::User", through: :product_items, source: :user
    
    def short_name
      if name.length > 15
        return name[0, 15] + '...'
      else
        return name
      end
    end
  end
end
