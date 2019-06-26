class AddUniqueThingName < ActiveRecord::Migration[5.2]
  def change
    add_index :devices, :thing_name, unique: true
  end
end
