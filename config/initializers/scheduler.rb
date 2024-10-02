# frozen_string_literal: true

if defined?(Rails::Server) || defined?(Sidekiq)
  require 'sidekiq'
  require 'sidekiq-cron'

  # 環境変数が設定されていることを確認
  if ENV['REDIS_URL'].present?
    # 毎日21時にLineNotificationJobを実行
    Sidekiq::Cron::Job.create(
      name: 'Daily LINE Notification - every day at 21:00',
      cron: '0 21 * * *',
      class: 'LineNotificationJob'
    )
  end
end
