class DevicesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @device = Device.find_by(device_params)
    if @device.present?
      @device.users << current_user
      flash[:notice] = "Successfully added device!"
    else
      flash[:alert] = "That device doesn't exist"
    end
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
