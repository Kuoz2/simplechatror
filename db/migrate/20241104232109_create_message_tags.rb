class CreateMessageTags < ActiveRecord::Migration[7.0]
  def change
    create_table :message_tags do |t|
      t.references :report, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true
      t.references :tagged_by, null: false, foreign_key: { to_table: :users }
      
      t.timestamps
    end
  end
end
