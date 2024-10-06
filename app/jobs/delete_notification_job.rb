# frozen_string_literal: true

#
# Send Notification in every 20 seconds which is configured in solid-queue yml
#
class DeleteNotificationJob < ApplicationJob
  self.queue_adapter = :solid_queue

  def perform
    Notification.delete_random_notification
  end
end
