# frozen_string_literal: true

#
# Concurrency test job which will be triggered from Rails Console
#
class ConcurrencyTestJob < ApplicationJob
  self.queue_adapter = :solid_queue
  self.queue_name = :foo_queue
  # limits_concurrency to: 2, key: ->(user) { user.id }, duration: 1

  def perform
  # def perform
    Rails.logger.info("Starting ConcurrencyTestJob @ #{Time.now}")
    sleep 15
    # Rails.logger.info("User is #{user.email}")
  end
end