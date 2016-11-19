class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def show
    @secret = Secret.find(params[:id])
  end

  def new
    @secret = Secret.new
  end

  def edit
    @secret = Secret.find(params[:id])
  end

  def update
    @secret = Secret.update_attributes(params[:secret])
    redirect_to secret_path(secret)
  end

  def destroy
  end
end
