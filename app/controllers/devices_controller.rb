class DevicesController < ApplicationController
  def show
    @device = Device.find(params[:id])
    @notification = @device.notification || Notification.new(device: @device)
  end
end
