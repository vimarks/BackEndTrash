Rails.application.routes.draw do
  resources :trashes
  resources :locations
  resources :wallets
  resources :users, only: [:create]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  post '/trashes/getUserTrash', to: 'trashes#getUserTrash'
  post '/trashes/getTrophies', to: 'trashes#getTrophies'
  post '/wallets/getUserWallet', to: 'wallets#getUserWallet'
  patch '/trashes/patchBounty/:id', to: 'trashes#patchBounty'
  resources :sessions, only: [:create]
end
