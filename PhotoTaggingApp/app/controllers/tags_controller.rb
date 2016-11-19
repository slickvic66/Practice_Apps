class TagsController < ApplicationController
  def create
    tag = Tag.create(params[:tag])
    render :json => tag
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    render :json => "Deleted"
  end

  def index
    tags = Tag.where(:photo_id => params[:photo_id])
    render :json => tags
  end
end
