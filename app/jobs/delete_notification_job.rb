# frozen_string_literal: true

#
# Send Notification in every 20 seconds which is configured in solid-queue yml
#
class DeleteNotificationJob < ApplicationJob
  self.queue_adapter = :solid_queue
  self.queue_name = :cleanup_queue

  def perform
    Rails.logger.info("Starting DeleteNotificationJob @ #{Time.now}")
    Notification.delete_random_notification
  end
end