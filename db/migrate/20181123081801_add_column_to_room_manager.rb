class AddColumnToRoomManager < ActiveRecord::Migration[5.2]
  def change
    add_column :room_managers, :accessed_at, :datetime
  end
end
