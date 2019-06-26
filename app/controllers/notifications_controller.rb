class NotificationsController < ApplicationController  
  def create
    @device = Device.find(params[:device_id])
    @notification = Notification.new(notification_params.merge(device: @device))
    @notification.numbers.reject(&:blank?)
      .map! { |n| n.gsub("-", "").prepend("1") }
    if @notification.generate! && @device.create_rule
      flash[:notice] = "Notification created successfully"
    else
      flash[:alert] = @notification.errors.full_messages.to_sentence
    end
    redirect_to @device
  end
  
  def update
    @notification = Notification.find(params[:id])
    if @notification.update(notification_params)
      flash[:notice] = "Notification updated successfully"
    else
      flash[:alert] = @notification.errors.full_messages.to_sentence
    end
    redirect_to @notification.device
  end
  
  private
  def notification_params
    params.require(:notification).permit(:max, :min, numbers: [])
  end
end
