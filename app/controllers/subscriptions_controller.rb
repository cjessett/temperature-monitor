class SubscriptionsController < ApplicationController
  before_action :set_objects

  def create
    number = params[:number].gsub("-", "").prepend("1")
    if @notification.add_subscription(number)
      flash[:notice] = "Subscription Added"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to @device
  end
  
  def destroy
    if @notification.remove_subscription(params[:id])
      flash[:notice] = "Subscription Removed"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to @device
  end
  
  private
  def set_objects
    @device       = Device.find(params[:device_id])
    @notification = Notification.find(params[:notification_id])
  end
end
