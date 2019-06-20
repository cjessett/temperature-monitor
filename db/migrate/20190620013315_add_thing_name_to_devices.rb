class AddThingNameToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :thing_name, :string
  end
end
