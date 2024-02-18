# frozen_string_literal: true

#
# Controller to handle the sessions related requests
#
class SessionsController < ApplicationController
  # Controller action to create sessions when user signs in
  #
  # POST /signin
  #
  # This action creates the session when user logs in
  #
  # Parameters:
  #   - email: Email of the user.
  #   - password: Password for user's account.
  #
  # Renders:
  #   - Redirect to the root path of the application.
  #   - Redirect to login page if the authentication fails.
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "You've signed in."
      session[:user_id] = @user.id

      # format.turbo_stream do
      #   render turbo_stream: [
      #     turbo_stream.replace('main', partial: 'developers/developer',
      #                                             locals: { developer: @developer })
      #   ]
      # end
      redirect_to root_path
    else
      flash[:alert] = 'There was a problem signing in. Please try again.'
      redirect_to signin_path
    end
  end

  # Controller action to destroy sessions when user signs out
  #
  # DELETE /signout
  #
  # This action nullify the session variables set during login
  #
  # Renders:
  #   - Turbo Stream to replace the main container.
  def destroy
    session[:user_id] = nil

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.replace('main', partial: 'sessions/logout')
        ]
      end

      format.html { redirect_to signin_path, notice: "You have signed out." }
      format.json { head :no_content }
    end
  end
end