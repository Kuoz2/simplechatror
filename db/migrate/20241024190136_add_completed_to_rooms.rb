class AddCompletedToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :completed, :boolean
  end
end
