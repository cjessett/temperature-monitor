module DevicesHelper
  DATA_PLANE = Aws::IoTDataPlane::Client.new(endpoint: ENV['ENDPOINT'])
end
