class DevicesController < ApplicationController
  def show
    @device = Device.find(params[:id])
  end
end
