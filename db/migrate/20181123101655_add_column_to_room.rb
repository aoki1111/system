class AddColumnToRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :posted_at, :datetime
  end
end
