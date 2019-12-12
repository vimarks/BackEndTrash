Rails.application.routes.draw do
  resources :trashes
  resources :locations
  resources :wallets
  resources :users, only: [:create]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  resources :sessions, only: [:create]
end
