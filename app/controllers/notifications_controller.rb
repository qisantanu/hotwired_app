# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Style/ParenthesesAroundCondition, Style/IfUnlessModifier

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
    if params[:search_notification].present?
      notifications = notifications.where('title ilike ?',
                                          "%#{params[:search_notification]}%")
    end

    @notifications = notifications.order('id desc')

    if params[:load].present?
      @current_page = params[:page].to_i + 1
      page_limit = Notification::PAGINATION

      if (Notification.all.count > page_limit * @current_page + page_limit)
        @next_page = @current_page + 1
      end

      @notifications = @notifications.offset((@next_page.presence || @current_page) * page_limit)
                                     .limit(page_limit)

      # @note This will target the notifications id within the
      #   turbo_frame_tag :notifications do in the _lists partial
      #   here we are also trying to update the load more link which we kept under the turbo frame

      # @note turbo_stream generally renders with POST
      respond_to do |format|
        format.html
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('notifications', partial: 'notifications/notification', collection: @notifications),
            turbo_stream.update('load_more', partial: 'notifications/load_more', locals: { page: @next_page })
          ] and return    
        end # POST
      end
    else
      # @note This will target the notifications id within the
      Rails.logger.info(" else request headers ===> #{request.format}")
      render turbo_stream: [
        turbo_stream.update('notifications', partial: 'notifications/notification', collection: @notifications)
      ]
    end
  end
end