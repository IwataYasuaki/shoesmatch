Rails.application.routes.draw do
  get 'shoes/index'
  get 'shoes/show'
  get 'shoes/create'
  get 'shoes/new'
  get 'shoes/destroy'
  get 'shoes/edit'
  get 'shoes/update'
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup',    to: 'users#new'
  resources :users
  resources :shoes
  root 'shoes#index'
end
