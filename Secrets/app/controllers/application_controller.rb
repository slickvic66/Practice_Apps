class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user

  def set_current_user
    if session[:token]
      @current_user ||= User.find_by_session_token(session[:token])
    end
  end

  def check_user_access(user)
    unless @current_user == user
      flash.notice = "You are not authorized to view that page"
      redirect_to new_session_path
    end
  end

  # def current_user
  #   @current_user
  # end

  # def logged_in?
  #   !!current_user
  # end

end
