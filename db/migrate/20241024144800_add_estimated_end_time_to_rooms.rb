class AddEstimatedEndTimeToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :estimated_end_time, :datetime
  end
end
