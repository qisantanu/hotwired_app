# frozen_string_literal: true

#
# Send Notification in every 15 seconds which is configured in solid-queue yml
#
class SendNotificationJob < ApplicationJob
  self.queue_adapter = :solid_queue
  self.queue_name = :background

  def perform
    Rails.logger.info("Starting SendNotificationJob @ #{Time.now}")
    Notification.fake_notification_stream
  end
end
