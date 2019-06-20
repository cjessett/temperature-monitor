class AddMinAndMaxTempToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :max_temp, :integer
    add_column :devices, :min_temp, :integer
  end
end
