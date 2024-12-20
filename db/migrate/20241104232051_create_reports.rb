class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
