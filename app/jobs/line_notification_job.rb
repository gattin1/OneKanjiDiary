# frozen_string_literal: true

# LINEに通知を送るクラス
class LineNotificationJob
  include Sidekiq::Job
  sidekiq_options unique: true

  def perform
    LineNotificationService.send_notifications
  end
end
