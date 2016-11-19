class DestinationsController < ApplicationController
  def new
    @destination = Destination.new
    @destination.trip_id = params[:trip_id]
  end

  def create
    photo_blob = params[:destination].delete(:image).read
    @destination = Destination.new(params[:destination])
    @destination.image = photo_blob
    if @destination.save
      flash[:success] = "#{@destination.name} created successfully"
      redirect_to trip_path(Trip.find_by_id(@destination.trip_id))
    else
      flash[:errors] = @destination.errors.full_messages
      render 'new'
    end
  end

  def show
    @destination = Destination.find(params[:id])
  end

  def destroy
  end

  def photo
    puts "IM HERE"
    destination = Destination.find(params[:destination_id])
    send_data destination.image, :type => 'image/jpg'
  end
end
