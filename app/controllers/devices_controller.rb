class DevicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @devices = current_user.devices      
  end
  
  def show
    @device = Device.find(params[:id])
    @notification = @device.notification || Notification.new(device: @device)
  end
end
