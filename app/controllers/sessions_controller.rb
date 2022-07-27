class SessionsController < ApplicationController

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
      flash[:alert] = "There was a problem signing in. Please try again."
      redirect_to signin_path
    end
  end

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