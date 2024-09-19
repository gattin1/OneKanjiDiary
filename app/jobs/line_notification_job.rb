class LineNotificationJob
  include Sidekiq::Job

  def perform
    User.send_line_notifications
  end
end
