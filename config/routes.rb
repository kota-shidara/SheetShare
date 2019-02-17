Rails.application.routes.draw do


  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#delete"
  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :sales, only: [:show, :new, :create, :edit, :update, :destroy]
  get "/sales/:id/step2" => "sales#step2"
  get "/sales/:id/check" => "sales#check"
  post "sales/:id/confirm" => "sales#confirm"
  get "/sales/:id/complete" => "sales#complete"
  root "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end