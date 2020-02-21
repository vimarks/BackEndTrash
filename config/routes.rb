Rails.application.routes.draw do
  resources :reputations
  post '/login', to: 'auth#create'
  resources :trashes
  resources :locations
  resources :wallets
  resources :users, only: [:create]
  get '/profile', to: 'users#profile'
  post '/trashes/getUserTrashCoords', to: 'trashes#getUserTrashCoords'
  post '/trashes/getTrophies', to: 'trashes#getTrophies'
  post '/wallets/getUserWallet', to: 'wallets#getUserWallet'
  patch '/trashes/patchBounty/:id', to: 'trashes#patchBounty'
  resources :sessions, only: [:create]
end
