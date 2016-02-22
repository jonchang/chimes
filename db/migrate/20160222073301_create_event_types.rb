class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.integer :length
      t.integer :warning_time
      t.integer :passing_time
      t.references :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
