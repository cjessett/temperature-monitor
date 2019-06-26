class Notification < ApplicationRecord
  belongs_to :device
  validates :arn, :min, :max, presence: true
  validate :min_cannot_be_greater_than_max
  after_update :update_rule
  attr_accessor :numbers, :subscriptions
  
  def generate!(name = "TempMonitor")
    topic = DevicesHelper.create_sns_topic(device.thing_name, name)
    numbers.each { |n| topic.subscribe(protocol: 'sms', endpoint: n) }
    self.update(arn: topic.arn)
  end
  
  def topic
    Aws::SNS::Topic.new(arn)
  end
  
  def update_rule
    self.device.update_rule
  end
  
  def subscriptions
    @subscriptions ||= get_subscriptions
  end
  
  def get_subscriptions
    topic.subscriptions
  end
  
  def add_subscription(number)
    topic.subscribe(protocol: 'sms', endpoint: number)
    subscriptions = get_subscriptions
  end
  
  def remove_subscription(arn)
    subscription = subscriptions.find { |s| s.arn === arn }
    subscription.delete()
    subscriptions = get_subscriptions
  end
  
  def min_cannot_be_greater_than_max
    return unless min && max
    if min >= max
      errors.add(:threshold, "Min must be less than Max")
    end
  end
end
