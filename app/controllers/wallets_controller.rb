class WalletsController < ApplicationController




  def getUserWallet
    puts params
    user_id = params['user_id'].to_i
    wallet = Wallet.all.select { |wallet| wallet.user_id == user_id}
    render json: {
      wallet: wallet
    }

  end
end
