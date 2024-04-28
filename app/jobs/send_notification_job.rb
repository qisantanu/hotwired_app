# frozen_string_literal: true

#
# Send Notification in every 15 seconds which is configured in solid-queue yml
#
class SendNotificationJob < ApplicationJob
  self.queue_adapter = :solid_queue

  def perform
    Notification.fake_notification_stream
  end
end
