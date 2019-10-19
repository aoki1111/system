class Item < ApplicationRecord
  belongs_to :user
  has_many :stock_items, dependent: :destroy
  validates :user_id, presence: true
end
