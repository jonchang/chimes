class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :time_zone
      t.binary :start_chime
      t.binary :warning_chime
      t.binary :passing_chime
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
