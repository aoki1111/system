class CreateProductItems < ActiveRecord::Migration[5.2]
  def change
    create_table :product_items do |t|
        t.references :user, foreign_key:true
        t.integer :product_id, index:true, foreign_key:true
      t.timestamps
    end
    add_index :product_items, [:user_id,:product_id], unique:true
  end
end
