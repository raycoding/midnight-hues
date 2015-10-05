class UserSessionsController < ApplicationController
  skip_before_action :login_required, :authorize, :only => [:new, :create,:destroy]
  layout "login"
  def new
    if current_user
      flash[:error]="You are already logged in"
      redirect_to root_url
      return
    else
      @user_session = UserSession.new
    end
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Welcome back #{@user_session.user.name}!"
      redirect_to root_url
      return
    else
      flash[:error] = "Error : Could not log in! #{@user_session.errors.full_messages.join(',')}"
      redirect_to login_path
      return
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:success] = "You have logged out"
    redirect_to login_path
  end
end