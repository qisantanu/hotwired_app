# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Style/IfUnlessModifier

#
# Controller to handle the notifications related requests
#
class NotificationsController < ApplicationController
  #
  # @note This action is not in use as of now.
  def index; end

  # Controller action to list notifications
  #
  # GET /notifications/lists
  #
  # This action retrieves a list of notifications, optionally filtered by a search query,
  # and renders them as a Turbo Stream to update the notifications container.
  #
  # Parameters:
  #   - search_notification: Search query string to filter notifications by title.
  #   - load: Flag indicating whether to load more notifications for pagination.
  #   - page: Page number for pagination.
  #
  # Renders:
  #   - Turbo Stream to update the notifications container.
  #   - If pagination is enabled, also updates the load more link.
  def lists
    notifications = Notification.all
    notifications = notifications.where('title ilike ?', "%#{params[:search_notification]}%") if params[:search_notification].present?
    page = params[:page].to_i || 1

    @notifications = notifications.limit(page * Notification::PAGINATION)
    @notifications = notifications.order('id desc')

    if params[:append].present?
      Rails.logger.info('coming from JS')
      render turbo_stream: [
        turbo_stream.update('notifications', partial: 'notifications/notification', collection: @notifications)
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
