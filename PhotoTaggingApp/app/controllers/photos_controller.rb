class PhotosController < ApplicationController
  def create
    url = params[:photo][:url]
    photo = Photo.create(:url => url)
    render :json => photo
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    render :json => "Deleted"
  end

  def index
    photos = Photo.all
    respond_to do |format|
      format.html
      format.json { render :json => photos }
    end
  end
end
