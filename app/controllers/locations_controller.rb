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
end
