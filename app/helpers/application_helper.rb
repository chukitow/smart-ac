module ApplicationHelper
  def friendly_notification_message(notification)
    issues = []
    issues << 'a value of Carbon Monoxide of over 9 PPM' if notification.measure.hight_carbon_monoxide?
    issues << "a health status of #{notification.measure.health_status}" if notification.measure.not_healthy?
    issues.to_sentence
  end
end
