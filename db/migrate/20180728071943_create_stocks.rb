class CreateStocks < ActiveRecord::Migration[5.2]
  def change
      create_table :stocks do |t|
        t.string :type
        t.boolean :box_flag
        t.integer :quantity
        t.integer :shipment_week
        t.text :remark
        t.datetime :salable
        t.references :user, foreign_key: true

        t.timestamps
      end
      add_index :stocks, [:shipment_week, :user_id], unique:true
  end
end
