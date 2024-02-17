class Notification < ApplicationRecord
  validates_presence_of :title, :description

  # probable status of a notification
  STATUS = {
    unread: 0,
    read: 1
  }.freeze


  # @return [Integer] define the per page count
  PAGINATION = 3

  # this is mainly for the notification bar in the right panel
  after_create_commit do
    sleep 2
    broadcast_prepend_to('notifications',
                          partial: 'notifications/notification',
                          target: 'notifications',
                          locals: { notification: self }
    )
  end

  # this is mainly for the notification bar in the right panel
  # when the notification will update, it will be replaced
  after_update_commit do
    sleep 2 
    broadcast_replace_to('notifications',
                          partial: 'notifications/notification',
                          target: "notification_#{self.id}",
                          locals: { notification: self }
    )
  end

  after_destroy_commit do
    sleep 2
    broadcast_remove_to('notifications',
      target: "notification_#{self.id}"
    )
  end

  def read?
    status == 1
  end

  def self.fake_notification_stream
    Notification.fake_notification
    Notification.fake_notification
    Notification.second.update(status: STATUS[:read])
    Notification.first.destroy
    Notification.last.destroy
    Notification.first.update(status: STATUS[:read])
    Notification.fake_notification
    Notification.last.update(status: STATUS[:read])
  end


  def self.fake_notification
    Notification.create(title: Faker::ProgrammingLanguage.name, description: Faker::Markdown.emphasis)
  end
end
