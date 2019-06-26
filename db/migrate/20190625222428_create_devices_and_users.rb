class CreateDevicesAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :devices_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :device, index: true
    end
  end
end
