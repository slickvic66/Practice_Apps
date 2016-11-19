class GistsController < ApplicationController
  def new
    @gist = Gist.new

    @gist.files.build
    @tags = Tag.all

    respond_to do |format|
      format.html
      format.json { render :json => @tags }
    end
  end

  def create
    gist = Gist.new(params[:gist])

    if gist.save
      redirect_to gists_path
    else
      render 'new'
    end

  end

  def index
    @user = User.find(cookies[:token])
    @gists = Gist.show_by_user(@user.id)
    @fav_gists = @user.favorites.map { |favorite| favorite.gist_id }

    respond_to do |format|
      format.html
      format.json { render :json => @favorites }
    end
  end

  def destroy
  end
end
