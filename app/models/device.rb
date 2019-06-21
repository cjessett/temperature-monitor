class Device < ApplicationRecord
  
  after_find :get_shadow
  attr_accessor :temperature, :timestamp
  
  def get_shadow
    resp             = DevicesHelper::DATA_PLANE.get_thing_shadow(thing_name: self.thing_name)
    shadow           = JSON.parse(resp.payload.string)
    self.temperature = shadow['state']['reported']['temp']
    self.timestamp   = shadow['metadata']['reported']['temp']['timestamp']
  end
  
  def create_rule(display:"TempMonitor", numbers:)
    topic = DevicesHelper.create_sns_topic(thing_name, display)
    params = {
      rule_name: rule_name,
      topic_rule_payload: {
        sql: build_sql,
        actions: [{
          sns: {
            target_arn: topic.arn,
            role_arn: ENV['SNS_ROLE_ARN'],
            message_format: "RAW",
          }
        }]
      }
    }
    DevicesHelper::IOT_CLIENT.create_topic_rule(params)
    numbers.each do |number|
      topic.subscribe({ protocol: 'sms', endpoint: number })
    end
  end
  
  def build_sql
    topic     = "$aws/things/#{thing_name}/shadow/update"
    attribute = "state.reported.temp"
    <<-SQL
      SELECT VALUE #{attribute}
      FROM '#{topic}'
      WHERE #{attribute} <= #{min_temp}
      OR #{attribute} >= #{max_temp}
    SQL
  end
  
  def rule
    DevicesHelper::IOT_CLIENT.get_topic_rule(rule_name: rule_name)
  end
  
  def rule_name
    "#{thing_name}_temp_threshold"
  end
  
  def formatted_timestamp
    t = Time.at timestamp
    t.strftime("%A, %B %d %Y, %I:%M %p #{t.zone}")
  end
end
