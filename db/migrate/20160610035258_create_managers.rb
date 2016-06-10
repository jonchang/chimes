class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.boolean :admin
      t.references :user, index: true, foreign_key: true
      t.references :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
