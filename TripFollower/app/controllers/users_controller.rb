class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:success] = "Welcome!"
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "You've updated your account successfully."
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
  end

  private

    def check_signin

    end
end
