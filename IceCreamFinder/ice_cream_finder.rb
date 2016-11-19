# Still need to build UI where they pick which place to go to.
# And write a regex to find and put a newline before Destination.

require 'rest-client'
require 'json'
require 'addressable/uri'
require 'nokogiri'
require './secret.rb'


def get_query
  origin = "160 Folsom St, San Francisco, CA 94105"
  query = "ice cream"
  range = "2000"

  origin_lat_lng = lat_lng(origin)
  nearby_places = nearby_places(origin_lat_lng, query,range)
  nearby_places = sort_by_rating(nearby_places)

  destination_lat_lng = nearby_places[0].values[0][:coords]

  directions(origin_lat_lng, destination_lat_lng)

end

def lat_lng(address)
  # Uses Google Geocode API to return the latitude/longitude at a given address

  request = Addressable::URI.new(
    :scheme => "http",
    :host => "maps.googleapis.com",
    :path => "maps/api/geocode/json",
    :query_values => {
      :address => address,
      :sensor => "false"
      }
    )

  response = RestClient.get(request.to_s)
  parsed_response = JSON.parse(response)

  lat = parsed_response["results"][0]["geometry"]["location"]["lat"]
  lng = parsed_response["results"][0]["geometry"]["location"]["lng"]

  [lat, lng]
end


#Returns array of hashes of form [{"Place Name" => {:rating => rating, :coords => [lat,lng]}]
def nearby_places(lat_lng, query, range)
  nearby_places = []

  request = Addressable::URI.new(
    :scheme => "https",
    :host => "maps.googleapis.com",
    :path => "maps/api/place/nearbysearch/json",
    :query_values => {
      :location => lat_lng.join(','),
      :radius => range,
      :types => "food",
      :keyword => query,
      :sensor => "false",
      :key => API_KEY
    }
  )

  response = RestClient.get(request.to_s)
  parsed_response = JSON.parse(response)

  parsed_response["results"].each do |result|
    lat = result["geometry"]["location"]["lat"]
    lng = result["geometry"]["location"]["lng"]
    rating = result["rating"]
    rating = 0 if rating.nil?
    nearby_places << {result["name"] => {:rating => rating, :coords => [lat, lng]}}
  end

  nearby_places
end

# Sorts by rating, returns highest to lowest
def sort_by_rating(nearby_places)
  nearby_places.sort_by! {|place| place.values[0][:rating]}

  nearby_places.reverse
end

# Takes in origin and destination latitude/longitude and returns directions
def directions(origin, destination)
  directions = []

  request = Addressable::URI.new(
    :scheme => "https",
    :host => "maps.googleapis.com",
    :path => "maps/api/directions/json",
    :query_values => {
      :origin => origin.join(','),
      :destination => destination.join(','),
      :sensor => "false",
      :mode => "walking"
    }
  )

  response = RestClient.get(request.to_s)

  parsed_response = JSON.parse(response)

  parsed_response["routes"][0]["legs"][0]["steps"].each do |step|
    parsed_html = Nokogiri::HTML(step["html_instructions"])
    directions << parsed_html.text
  end

  directions
end



