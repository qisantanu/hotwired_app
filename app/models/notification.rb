class Notification < ApplicationRecord
  validates_presence_of :title, :description

  # probable status of a notification
  STATUS = {
    unread: 0,
    read: 1
  }.freeze


  # @return [Integer] define the per page count
  PAGINATION = 5

  # this is mainly for the notification bar in the right panel
  after_create_commit do
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
    notif = Notification.fake_notification
    notif_other = Notification.fake_notification
    notif_other.update(status: STATUS[:read])
    notif.update(status: STATUS[:read])
    Notification.fake_notification
    Notification.last.update(status: STATUS[:read])
    Notification.fake_notification
  end

  def self.delete_random_notification
    (0..rand(10)).each do |i|
      Notification.find(Notification.pluck(:id).sample).destroy
    end
  end

  def self.bulk_create_for_testing
    50.times do |_|
      Notification.fake_notification
    end
  end

  def self.fake_notification
    Notification.create(title: Faker::ProgrammingLanguage.name, description: Faker::Markdown.emphasis)
  end
end
