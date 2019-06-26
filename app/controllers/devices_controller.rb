class DevicesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    device = Device.find_or_create_by(device_params)
    device.users << current_user
    flash[:notice] = "Successfully added device!"
    redirect_to action: "index"
  end

  def index
    @devices = current_user.devices   
  end
  
  def show
    @device = Device.find(params[:id])
    @notification = @device.notification || Notification.new(device: @device)
  end
  
  private
  def device_params
    params.require(:device).permit(:thing_name)
  end
end
