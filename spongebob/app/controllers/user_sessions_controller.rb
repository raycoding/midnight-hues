class UserSessionsController < ApplicationController
  skip_before_action :login_required, :authorize, :only => [:new, :create,:destroy]
  def new
    if current_user
      flash[:error]="Your are already logged in"
      redirect_to root_url
      return
    else
      @user_session = UserSession.new
    end
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:sucess] = "You are logged in."
      redirect_to root_url
      return
    else
      flash[:error] = "Errors : #{@user_session.errors.full_messages.join(',')}"
      redirect_to login_path
      return
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to login_path
  end
end