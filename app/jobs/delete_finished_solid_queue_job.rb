# frozen_string_literal: true

#
# Delete Finsihed jobs in every day at 2AM
#
class DeleteFinishedSolidQueueJob < ApplicationJob
  self.queue_adapter = :solid_queue
  self.queue_name = :cleanup_queue
  
  def perform
    Rails.logger.info("Starting DeleteFinishedSolidQueueJob @ #{Time.now}")
    SolidQueue::Job.clear_finished_in_batches
  end
end