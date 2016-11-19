class FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(:gist_id => params[:gist_id], :user_id => cookies[:token])
    saved = favorite.save!

    respond_to do |format|
      format.json { render :json => saved }
    end
  end

  def destroy
    user = User.find(cookies[:token])
    favorite = user.favorites.find_by_gist_id(params[:gist_id])
    favorite.destroy

    respond_to do |format|
      format.json { render :json => favorite }
    end
  end
end
