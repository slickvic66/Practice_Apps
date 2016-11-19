class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user
      sign_in(user)
      redirect_to user_path(user)
    else
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
