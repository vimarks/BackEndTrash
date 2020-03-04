class ReputationsController < ApplicationController

  def index
  end

  def create
    reporter_id = params[:reporter_id]
    cleaner_id = params[:cleaner_id]
    trash_id = params[:trash_id]
    rating = params[:rating]
    new_rep = Reputation.new(
      user_id: reporter_id,
      cleaner_id: cleaner_id.to_i,
      trash_id: trash_id,
      rating: rating
    )
    if new_rep.save

    # users_reviews = Reputation.all.select { |reputation| reputation.user_id === reporter_id }
    # count = users_reviews.length
    # user_rating = users_reviews.map { |rev| rev[:rating]}.sum/count

    render json: {
      reputations: Reputation.all

      
    }
    else
      puts "****** no reviews for this user ******"
    end

  end

end
