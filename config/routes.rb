Rails.application.routes.draw do
  resources :images
  resources :reputations
  post '/login', to: 'auth#create'
  resources :trashes
  resources :locations
  resources :wallets
  resources :users, only: [:create]
  get '/profile', to: 'users#profile'
  post '/trashes/initialCFetch', to: 'trashes#initialCFetch'
  post '/trashes/myTrash', to: 'trashes#myTrash'
  post '/trashes/getTrophies', to: 'trashes#getTrophies'
  post '/wallets/getUserWallet', to: 'wallets#getUserWallet'
  patch '/trashes/patchBounty/:id', to: 'trashes#patchBounty'
  resources :sessions, only: [:create]
end
