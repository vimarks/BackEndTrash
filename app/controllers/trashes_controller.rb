class TrashesController < ApplicationController
  def create

    bounty = params["bounty"]
    location_id = params["location_id"]
    cleaner_id = params["cleaner_id"]
    cleaned = params["cleaned"]
    description = params["description"]
    reporter_id = params["reporter_id"]
    trash = Trash.new(
      bounty: bounty,
      location_id: location_id,
      cleaner_id: cleaner_id,
      cleaned: cleaned,
      description: description,
      reporter_id: reporter_id
      )
    if trash.save
      render json: {
      allTrash: Trash.all
      }
    end


  end

end
