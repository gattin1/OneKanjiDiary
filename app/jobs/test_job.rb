class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "ActiveJob is running via Sidekiq! Arguments: #{args.inspect}"
  end
end
