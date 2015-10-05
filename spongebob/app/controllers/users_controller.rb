class UsersController < ApplicationController
  skip_before_action :login_required, :authorize, :only => [:new, :create]
  acl_check :cal_login, :all_actions => :manage
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to root_url
    else
      flash[:error] = "Errors : #{@user.errors.full_messages.join(',')}"
      redirect_to :back
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to :back
    else
      flash[:error] = "Errors : #{@user.errors.full_messages.join(',')}"
      redirect_to :back
    end
  end
end