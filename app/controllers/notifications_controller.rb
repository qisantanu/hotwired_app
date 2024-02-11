class NotificationsController < ApplicationController
  def index
    @notifications = Notification.order('id desc')
  end

  def lists
    @notifications = Notification.order('id desc')
  end
end