module DevicesHelper
  DATA_PLANE = Aws::IoTDataPlane::Client.new(endpoint: ENV['ENDPOINT'])
  IOT_CLIENT = Aws::IoT::Client.new

  def self.create_sns_topic(thing_name, display)
    sns    = Aws::SNS::Resource.new
    name   = "#{thing_name}TempWarning"
    params = { name: name, attributes: { DisplayName: display } }
    sns.create_topic(params)
  end
end
