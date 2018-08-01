class AddColumnToStock < ActiveRecord::Migration[5.2]
  def change
      add_column :stocks, :accept_order_count, :integer, index: true,default:0
      add_column :stocks, :pref, :string, index: true
      add_column :stocks, :area, :string, index: true
      add_column :postages, :area, :string, index:true
      add_index :postages, [:id, :item_type], unique:true
  end
end
