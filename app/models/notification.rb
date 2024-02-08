class Notification < ApplicationRecord
  validates_presence_of :title, :description

  def self.fake_notification
    Notification.create(title: Faker::ProgrammingLanguage.name, description: Faker::Markdown.emphasis)
  end
end
