Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :users do
    member do  # Another implicit convention, member = id. And collection = /users/followers or /users/following
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get   "/users/:user_id/preferences", to: "user_preferences#show",   as: "user_preferences"  # This is how routes should be declared. NO MAGIC
  patch "/users/:user_id/preferences", to: "user_preferences#update"
  put   "/users/:user_id/preferences", to: "user_preferences#update"
  post  "/users/:user_id/preferences", to: "user_preferences#update"

end