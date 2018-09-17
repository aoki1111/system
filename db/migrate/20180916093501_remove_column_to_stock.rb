class RemoveColumnToStock < ActiveRecord::Migration[5.2]
  def change
      remove_column :stocks, :type
      remove_column :stocks, :box_flag
  end
end
