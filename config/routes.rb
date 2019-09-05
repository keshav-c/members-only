Rails.application.routes.draw do
  root 'static_pages#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]
  resources :posts, only: [:new, :create, :index]
end
