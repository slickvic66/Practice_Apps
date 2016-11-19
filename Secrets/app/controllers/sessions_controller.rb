class SessionsController < ApplicationController
   def new
   end

   def create
    user = User.find_by_user_name(params[:user_name])

    if user.nil?
      flash.notice = "Incorrect Username"
      render "new"
      return
    end

    @user = user

    unless @user.authenticate(params[:password])
      flash.notice = "Incorrect Password"
      render "new"
      return
    end

    @user.session_token = SecureRandom.base64
    session[:token] = @user.session_token
    @user.save!
    redirect_to user_path(@user)

   end

   def destroy
    user = User.find_by_session_token(session[:token])
    user.session_token = 'null'
    user.save!
    flash.notice = "Logged Out!"
    redirect_to new_session_path
   end
end
