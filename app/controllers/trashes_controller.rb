class TrashesController < ApplicationController
  def initialCFetch
    cleaner_id = params["cleaner_id"].to_i
    trash = Trash.all
    rated_trash_ids = Reputation.all.select { |rep| rep.trash_id != nil}
                                    .map { |rep| rep.trash_id}
    if trash
      render json: {
        trash: trash,
        cleanTrashLocations: trash
          .select { |trash| trash.cleaner_id === cleaner_id}
          .select { |trash| trash.cleaned === "clean"}
          .map { |trash| trash.location },
        dirtyTrashLocations: trash
          .select { |trash| trash.cleaned === "dirty"}
          .map { |trash| trash.location },
        confirmedTrashLocations: trash
          .select { |trash| trash.cleaner_id === cleaner_id}
          .select { |trash| trash.cleaned === "confirmed"}
          .select { |trash| !rated_trash_ids.include? trash.id}
          .map { |trash| trash.location},
        users: User.all,
        reputations: Reputation.all,
        images: Image.all
      }
    end
  end


  def myTrash
    trash = Trash.all
    locations = Location.all

    currentUser_id = params["currentUser_id"].to_i
    clean_success = trash.select { |tr| tr.cleaner_id === currentUser_id && tr.cleaned === "confirmed" }
    clean_success_coords = clean_success.map { |tr| tr.location }
    pending_their_confirm = trash.select { |tr| tr.cleaner_id === currentUser_id && tr.cleaned === "clean" }
    pending_their_confirm_coords = pending_their_confirm.map { |tr| tr.location }
    report_success = trash.select { |tr| tr.reporter_id === currentUser_id && tr.cleaned === "confirmed" }
    report_success_coords = report_success.map { |tr| tr.location }
    pending_clean = trash.select { |tr| tr.reporter_id === currentUser_id && tr.cleaned === "dirty" }
    pending_clean_coords = pending_clean.map { |tr| tr.location }
    pending_your_confirm = trash.select { |tr| tr.reporter_id === currentUser_id && tr.cleaned === "clean" }
    pending_your_confirm_coords = pending_your_confirm.map { |tr| tr.location}
    wallet_balance = Wallet.find { |wallet| wallet.user_id === currentUser_id }.balance

      render json: {
        allTrash: Trash.all,
        clean_success: clean_success,
        clean_success_coords: clean_success_coords,
        pending_their_confirm: pending_their_confirm,
        pending_their_confirm_coords: pending_their_confirm_coords,
        report_success: report_success,
        report_success_coords: report_success_coords,
        pending_clean: pending_clean,
        pending_clean_coords: pending_clean_coords,
        pending_your_confirm: pending_your_confirm,
        pending_your_confirm_coords: pending_your_confirm_coords,
        userBalance: wallet_balance,
        allImages: Image.all,
        allUsers: User.all,
        allReputations: Reputation.all
      }
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
    posting_title = params["postingTitle"]
    bounty = params["bounty"]
    location_id = params["location_id"]
    cleaner_id = params["cleaner_id"]
    cleaned = params["cleaned"]
    description = params["description"]
    reporter_id = params["reporter_id"].to_i
    trash = Trash.new(
      title: posting_title,
      bounty: bounty,
      location_id: location_id,
      cleaner_id: cleaner_id,
      cleaned: cleaned,
      description: description,
      reporter_id: reporter_id
      )
    if trash.save
      render json: {
        id: trash.id,
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
    currentUser_id = params[:currentUser_id].to_i
    params[:patchBody].keys.map { |key| trash[key] = params[:patchBody][key]}
    trash.bounty = trash.bounty.to_i
    trash.save
    pending_clean = Trash.all.select { |tr| tr.reporter_id === currentUser_id && tr.cleaned === "dirty" }
    render json: {
      pending_clean: pending_clean
      allTrash: Trash.all,
    }
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

      rep = Reputation.new(
        user_id: reporter_id,
        cleaner_id: cleaner_id.to_i,
        trash_id: trash,
        rating: 5
      )
      rep.save
    end
    pending_your_confirm = Trash.all.select { |tr| tr.reporter_id === reporter_id && tr.cleaned === "clean" }
    report_success = Trash.all.select { |tr| tr.reporter_id === reporter_id && tr.cleaned === "confirmed" }
    reporter_trash = Trash.select { |trash| trash.reporter_id === reporter_id }
    render json: {allTrash: Trash.all.select { |trash| trash.cleaned != "confirmed"},
                  dirtyUserTrashCoords: reporter_trash.select { |trash| trash.cleaned == "dirty"}
                                                 .map { |trash| trash.location },
                  cleanUserTrashCoords: reporter_trash.select { |trash| trash.cleaned == "clean"}
                                                 .map { |trash| trash.location },
                  dirtyTrashLocations: Trash.all.select { |trash| trash.cleaned == "dirty"}
                                                 .map { |trash| trash.location},
                  cleanTrashLocations: Trash.all.select { |trash| trash.cleaned == "clean"}
                                                 .map { |trash| trash.location},
                  report_success: report_success,
                  pending_your_confirm: pending_your_confirm,
                  trash: Trash.all
                  }
  end


  def destroy



  end
end
