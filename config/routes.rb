Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to:"users#new"
  resources :users, only: [:index,:show,:new,:create,:edit,:update,:destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  post "users/:id/update", to: "users#update"
  resources :microposts, only: [:create,:edit,:update,:destroy]
  post "microposts/:id/update", to: "microposts#update"
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
