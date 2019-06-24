class RemoveMaxAndMinFromDevice < ActiveRecord::Migration[5.2]
  def change
    remove_column :devices, :max_temp, :integer
    remove_column :devices, :min_temp, :integer
  end
end
