Rails.application.routes.draw do


  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#delete"
  resources :users, only: [:show, :new, :create, :edit, :update]

  root "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end