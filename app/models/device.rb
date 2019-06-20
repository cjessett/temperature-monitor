class Device < ApplicationRecord
  
  def temperature
    resp   = DevicesHelper::CLIENT.get_thing_shadow(thing_name: thing_name)
    shadow = JSON.parse(resp.payload.string)
    shadow['state']['reported']['temp']
  end
end
