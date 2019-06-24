class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :max
      t.integer :min
      t.references :device, foreign_key: true

      t.timestamps
    end
  end
end
