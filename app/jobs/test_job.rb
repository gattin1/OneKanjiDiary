class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
   Rails.logger.info "TestJob is working! Arguments: #{args.inspect}"
  end
end
