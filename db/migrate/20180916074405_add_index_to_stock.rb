class AddIndexToStock < ActiveRecord::Migration[5.2]
  def change
      add_index :stocks, [:user_id, :product_id, :shipment_week], unique:true
      remove_index :stocks, [:shipment_week, :user_id]
  end
end
