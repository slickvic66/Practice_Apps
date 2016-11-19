class UsersController < ApplicationController
  def create
    user = User.new(params[:user])

    unless user.save
      redirect_to new_session_path
    end

    redirect_to gists_path
  end

  def show
    @user = User.find(cookies[:token])
  end
end
