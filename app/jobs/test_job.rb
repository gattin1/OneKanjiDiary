class TestJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info "TestJob is working. Message: #{message}"
  end
end
