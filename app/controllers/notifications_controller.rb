class NotificationsController < ApplicationController
  def index
    @notifications = Notification.order('id desc')
  end
end