class LineNotificationJob
  include Sidekiq::Job

  def perform
    LineNotificationService.send_notifications
  end
end
