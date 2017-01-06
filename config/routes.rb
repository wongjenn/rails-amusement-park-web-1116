Rails.application.routes.draw do

  get '/', to: 'users#homepage', as: 'root'
  get '/logout', to: 'sessions#logout', as: 'logout'
  get '/signin', to: 'sessions#signin', as: 'signin'
  post '/sessions/create', to: 'sessions#create'
  resources :attractions
  resources :users
end
