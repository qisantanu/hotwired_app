Rails.application.config.x.solid_queue_record_hook_ran = false

ActiveSupport.on_load(:solid_queue_record) do
  raise "Expected to run on SolidQueue::Record, got #{self.inspect}" unless self == SolidQueue::Record
  Rails.application.config.x.solid_queue_record_hook_ran = true
end

SolidQueue.on_start { process_something_on_start }
SolidQueue.on_stop { process_something_on_finish }

def process_something_on_start
  Rails.logger.info("The Solid Queue has been started at:#{Time.now} ")
end

def process_something_on_finish
  Rails.logger.info("The Solid Queue has been finished at:#{Time.now} ")
end