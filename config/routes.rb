Rails.application.routes.draw do
  root 'static_pages#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
