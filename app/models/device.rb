class Device < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :notification, dependent: :destroy
  validates :thing_name, presence: true
  after_find :get_shadow
  attr_accessor :temperature, :timestamp, :rule
  
  def get_shadow
    begin
      resp             = DevicesHelper::DATA_PLANE.get_thing_shadow(thing_name: self.thing_name)
      shadow           = JSON.parse(resp.payload.string)
      self.temperature = shadow['state']['reported']['temp']
      self.timestamp   = shadow['metadata']['reported']['temp']['timestamp']
    rescue StandardError => e
      puts "Rescued #{e.inspect}"
    end
  end
  
  def create_rule
    begin
      params = {
        rule_name: rule_name,
        topic_rule_payload: {
          sql: build_sql,
          actions: [{
            sns: {
              target_arn: notification.arn,
              role_arn: ENV['SNS_ROLE_ARN'],
              message_format: "RAW",
            }
          }]
        }
      }
      DevicesHelper::IOT_CLIENT.create_topic_rule(params)
    rescue StandardError => e
      puts "Rescued #{e.inspect}"
      false
    end
  end
  
  def build_sql
    topic     = "$aws/things/#{thing_name}/shadow/update"
    attribute = "state.reported.temp"
    <<-SQL
      SELECT VALUE #{attribute}
      FROM '#{topic}'
      WHERE #{attribute} <= #{notification.min}
      OR #{attribute} >= #{notification.max}
    SQL
  end
  
  def rule
    @rule ||= get_rule
  end

  def get_rule
    begin
      resp = DevicesHelper::IOT_CLIENT.get_topic_rule(rule_name: rule_name)
      resp.rule
    rescue StandardError => e
      puts "Rescued #{e.inspect}"
    end
  end
  
  def rule_name
    "#{thing_name}_temp_threshold"
  end
  
  def formatted_timestamp
    t = Time.at timestamp
    t.strftime("%A, %B %d %Y, %I:%M %p #{t.zone}")
  end
end
