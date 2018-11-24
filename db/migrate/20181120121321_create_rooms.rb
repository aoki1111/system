class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :order_product_id, :index => true

      t.timestamps
    end
  end
end
