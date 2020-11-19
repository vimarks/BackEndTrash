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
      reporter_id = params["reporter_id"].to_i
      reporter_trash = Trash.select { |trash| trash.reporter_id === reporter_id }
      location = Location.find(params[:id].to_i)
      latitude =  params["latitude"]
      longitude = params["longitude"]
      location.latitude = latitude
      location.longitude = longitude
      if location.save
        render json: {
          dirtyUserTrashCoords: reporter_trash.select { |trash| trash.cleaned === "dirty"}
                                              .map { |trash| trash.location}
        }
      end


  end
end
