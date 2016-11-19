class UsersController < ApplicationController
  before_filter :get_user, :check_access, :except => [:new,
    :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash.notice = "User Created!"
      redirect_to new_session_path
    else
      flash.notice = @user.errors.full_messages.join("<br>").html_safe
      render "new"
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_session_token(session[:token])
  end

  def update
    @user = User.find_by_session_token(session[:token])
    @user.update_attributes(params[:user])
    flash.notice = "Updated!"
    redirect_to user_path(@user)
  end

  def destroy
    @user.destroy
    flash.notice = "Account deleted"
    redirect_to new_session_path
  end

  def get_user
    @user = User.find(params[:id])
  end

  def check_access
    check_user_access(@user)
  end


end
