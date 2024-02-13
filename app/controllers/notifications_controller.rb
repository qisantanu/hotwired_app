#
# <Description>
#
class NotificationsController < ApplicationController
  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def index; end

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def lists
    notifications = Notification.all
    notifications = notifications.where('title ilike ?', "%#{params[:search_notification]}%") if params[:search_notification].present?
    @notifications = notifications.order('id desc')

    # this will target the notifications id within the
    # turbo_frame_tag :notifications do in the _lists partial
    render turbo_stream: [
      turbo_stream.update('notifications', partial: 'notifications/notification', collection: @notifications)
    ]
  end
end