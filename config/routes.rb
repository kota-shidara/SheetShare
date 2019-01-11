Rails.application.routes.draw do

  get "users/new" => "users#new"
  post "users/create" => "users#create"

  get "/" => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
