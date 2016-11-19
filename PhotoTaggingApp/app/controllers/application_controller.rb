class ApplicationController < ActionController::Base
  protect_from_forgery

  skip_before_filter :verify_authenticity_token, :if => :json?

  def json?
    params[:format] == 'json'
  end
end
