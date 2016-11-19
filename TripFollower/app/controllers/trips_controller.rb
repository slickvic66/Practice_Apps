class TripsController < ApplicationController

  def new
    @trip = Trip.new
    @trip.user_id = params[:user_id]
  end

  def create
    @trip = Trip.new(params[:trip])
    if @trip.save
      flash[:success] = "Trip created successfully"
      redirect_to user_path(User.find_by_id(@trip.user_id))
    else
      flash[:errors] = @trip.errors.full_messages
      render 'new'
    end
  end

  def show
    @trip = Trip.find(params[:id])
  end

end
