module SessionsHelper
  def sign_in(user)
    cookies[:token] = user.id
  end

  def sign_out
    cookies.delete(:token)
  end

  def signed_in?
    cookies[:token]
  end
end
