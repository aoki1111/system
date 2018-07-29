class CreateOrders < ActiveRecord::Migration[5.2]
  def change
      create_table :orders do |t|
        t.string :lastname
        t.string :firstname
        t.string :zipcode
        t.string :area
        t.string :pref
        t.string :city
        t.string :street
        t.string :building
        t.string :phone
        t.integer :quantity
        t.boolean :shipment_complete, default: false
        t.string :trailing_id
        t.references :user, foreign_key: true
        t.references :stock, foreign_key: true

        t.timestamps
      end
      add_index :orders, [:user_id, :created_at]
      add_index :orders, [:stock_id, :created_at]
      add_index :orders, :area
  end
end
