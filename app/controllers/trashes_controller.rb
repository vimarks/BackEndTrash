class TrashesController < ApplicationController
  def index

    trash = Trash.all
    if trash
      render json: {
        trash: trash,
        trashLocations: trash.select { |trash| trash.cleaned != "confirmed"}
        .map { |trash| trash.location },
        cleanTrashLocations: trash.select { |trash| trash.cleaned === "clean"}
        .map { |trash| trash.location },
        dirtyTrashLocations: trash.select { |trash| trash.cleaned === "dirty"}
        .map { |trash| trash.location }
      }
    end

  end

  def getUserTrashCoords

    trash = Trash.all
    reporter_id = params["reporter_id"].to_i
    reporter_trash = trash.select { |trash| trash.reporter_id === reporter_id }
    if Trash.all.find { |trash| trash.reporter_id === reporter_id}
      render json: {
        trash: trash,
        dirtyUserTrashCoords: reporter_trash.select { |trash| trash.cleaned === "dirty"}
                                            .map { |trash| trash.location },
        cleanUserTrashCoords: reporter_trash.select { |trash| trash.cleaned === "clean"}
                                            .map { |trash| trash.location }
      }
    else
      render json: {
        dirtyUserTrashCoords: [],
        cleanUserTrashCoords: [],
        trash: trash
      }
    end

  end

  def getTrophies

    trash = Trash.all
    user_id = params["user_id"].to_i
    userTrophies = trash.select { |trash| trash.cleaner_id === user_id}
                        .select { |trash| trash.cleaned == "confirmed"}
    render json: {
      userTrophies: userTrophies
    }

  end


  def create

    bounty = params["bounty"]
    location_id = params["location_id"]
    cleaner_id = params["cleaner_id"]
    cleaned = params["cleaned"]
    description = params["description"]
    reporter_id = params["reporter_id"].to_i
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
      trash: Trash.all,
      dirtyUserTrashCoords: Trash.select { |trash| trash.reporter_id === reporter_id }
                      .select { |trash| trash.cleaned === "dirty"}
                      .map { |trash| trash.location },
      cleanUserTrashCoords: Trash.select { |trash| trash.reporter_id === reporter_id }
                      .select { |trash| trash.cleaned === "clean"}
                      .map { |trash| trash.location }
      }
    end
  end

  def patchBounty

    trash = Trash.find(params[:id])
    trash.bounty = params['bounty'].to_i
    trash.save
    render json: {allTrash: Trash.all}

  end

  def update
    trash = Trash.find(params[:id])
    if trash.cleaned === "dirty"
      trash.cleaned = "clean"
      trash.cleaner_id = params['cleaner_id'].to_i
      trash.save
    else
      trash.cleaned = "confirmed"
      trash.save

      bounty = trash.bounty
      cleaner_id = trash.cleaner_id
      reporter_id = trash.reporter_id
      cleanerWallet = Wallet.all.find { |wallet| wallet.user_id == cleaner_id}
      reporterWallet = Wallet.all.find { |wallet| wallet.user_id == reporter_id}
      cleanerWallet.balance = cleanerWallet.balance + bounty
      reporterWallet.balance = reporterWallet.balance - bounty
      cleanerWallet.save
      reporterWallet.save

    end

    reporter_trash = Trash.select { |trash| trash.reporter_id === reporter_id }
    render json: {allTrash: Trash.all.select { |trash| trash.cleaned != "confirmed"},
                  dirtyUserTrashCoords: reporter_trash.select { |trash| trash.cleaned == "dirty"}
                                                 .map { |trash| trash.location },
                  cleanUserTrashCoords: reporter_trash.select { |trash| trash.cleaned == "clean"}
                                                 .map { |trash| trash.location },
                  dirtyTrashLocations: Trash.all.select { |trash| trash.cleaned == "dirty"}
                                                 .map { |trash| trash.location},
                  cleanTrashLocations: Trash.all.select { |trash| trash.cleaned == "clean"}
                                                 .map { |trash| trash.location}
                  }

  end


  def destroy



  end

end
