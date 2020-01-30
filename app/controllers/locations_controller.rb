class LocationsController < ApplicationController
  def create

    latitude = params["latitude"]
    longitude = params["longitude"]
    location = Location.new(
      latitude: latitude,
      longitude: longitude)
      if location.save
        render json: {
          id: location.id
        }

      end
  end
  def update
      location = Location.find(params[:id].to_i)
      latitude =  params["latitude"]
      longitude = params["longitude"]
      location.latitude = latitude
      location.longitude = longitude
      puts location.latitude
      if location.save
        render json: {
          locations: Location.all
        }
      end


  end
end
