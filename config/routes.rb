Rails.application.routes.draw do
  resources :trashes
  resources :locations
  resources :wallets
  resources :users, only: [:create]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  post '/trashes/getUserTrash', to: 'trashes#getUserTrash'
  post '/wallets/getUserWallet', to: 'wallets#getUserWallet'
  resources :sessions, only: [:create]
end
