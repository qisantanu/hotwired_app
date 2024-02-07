class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :print_for_debugging

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def authorize
    if !current_user
      flash[:alert] = "You aren't authorized to visit that page."
      redirect_to signin_path
    end
  end

  private

  def print_for_debugging
    Rails.logger.info("Request format: #{request.format}")
  end
end
