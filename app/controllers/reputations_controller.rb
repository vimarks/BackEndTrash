class ReputationsController < ApplicationController

  def index
  end

  def create
    reporter_id = params[:reporter_id]
    new_rating = params[:rating]
    new_rep = Reputation.new(
      user_id: reporter_id,
      rating: new_rating
    )
    if new_rep.save

    users_reviews = Reputation.all.select { |reputation| reputation.user_id === reporter_id }
    count = users_reviews.length
    user_rating = users_reviews.map { |rev| rev[:rating]}.sum/count

    render json: {
      avgRating: user_rating
    }
    else
      puts "****** no reviews for this user ******"
    end

  end

end
