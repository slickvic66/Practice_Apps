module SessionsHelper

  def log_in(user)
    cookies[:token] = user.id
  end

  def logged_in?
    cookies[:token]
  end

  def log_out
    cookies.delete(:token)
  end
end
