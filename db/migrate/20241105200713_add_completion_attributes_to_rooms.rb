class AddCompletionAttributesToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :completion_date, :date
    add_column :rooms, :completion_time, :time
  end
end
