class AddArnToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :arn, :string
  end
end
