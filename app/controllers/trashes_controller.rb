class TrashesController < ApplicationController
  def index

    trash = Trash.all
    if trash
      render json: {
        trash: trash,
        trashLocations: trash.select { |trash| trash.cleaned != "confirmed"}.map { |trash| trash.location }
      }
    end

  end

  def getUserTrash

    trash = Trash.all
    reporter_id = params["reporter_id"].to_i
    if Trash.all.find { |trash| trash.reporter_id === reporter_id}
      render json: {
        trash: trash,
        userTrash: trash.select { |trash| trash.reporter_id === reporter_id }
                        .select { |trash| trash.cleaned != "confirmed"}
                        .map { |trash| trash.location }
      }
    else
      render json: {
        userTrash: [],
        trash: trash
      }
    end

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
      userTrash: Trash.all.select { |trash| trash.reporter_id === reporter_id }.map { |trash| trash.location}
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

    render json: {allTrash: Trash.all.select { |trash| trash.cleaned != "confirmed"},
                  userTrash: Trash.all.select { |trash| trash.reporter_id === reporter_id }
                      .select { |trash| trash.cleaned != "confirmed"}
                      .map { |trash| trash.location }
                  }

  end


  def destroy



  end

end
