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
      @current_page = params[:page].to_i + 1
      page_limit = Notification::PAGINATION
      @notifications = @notifications.offset(@current_page * page_limit)
                                     .limit(page_limit)

      if (Notification.all.count > page_limit * @current_page + page_limit)
        @next_page = @current_page + 1
      end
      # this will target the notifications id within the
      # turbo_frame_tag :notifications do in the _lists partial
      # here we will try to change from the turbo.erb file.

      render turbo_stream: [
        turbo_stream.append('notifications', partial: 'notifications/notification', collection: @notifications),
        turbo_stream.replace('load_more', partial: '_load_more', local: { page: @next_page })
      ] and return

    else
      # this will target the notifications id within the
      # turbo_frame_tag :notifications do in the _lists partial
      render turbo_stream: [
        turbo_stream.update('notifications', partial: 'notifications/notification', collection: @notifications)
      ]
    end
  end
end
