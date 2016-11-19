class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_user_name(params[:session][:user_name])
    if user
      log_in(user)

      redirect_to gists_path
    else
      render "new"
    end
  end

  def index

  end

  def destroy
    log_out
    redirect_to root_path
  end
end
