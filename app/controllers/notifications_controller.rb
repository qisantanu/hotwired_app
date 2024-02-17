# frozen_string_literal: true

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
  # GET /notifications/lists
  #
  #
  def lists
    notifications = Notification.all
    if params[:search_notification].present?
      notifications = notifications.where('title ilike ?',
                                          "%#{params[:search_notification]}%")
    end

    @notifications = notifications.order('id desc')

    if params[:load].present?
      page = params[:page].to_i + 1
      @notifications = @notifications.offset(page * Notification::PAGINATION)
                                     .limit(Notification::PAGINATION)

      # this will target the notifications id within the
      # turbo_frame_tag :notifications do in the _lists partial
      render turbo_stream: [
        turbo_stream.append('notifications', partial: 'notifications/notification', collection: @notifications)
      ]

    else
      # this will target the notifications id within the
      # turbo_frame_tag :notifications do in the _lists partial
      render turbo_stream: [
        turbo_stream.update('notifications', partial: 'notifications/notification', collection: @notifications)
      ]
    end
  end
end
