Rails.application.routes.draw do

#   Prefix Verb   URI Pattern               Controller#Action
#     login GET    /login(.:format)          users#login_form
#           POST   /login(.:format)          users#login
#    logout POST   /logout(.:format)         users#logout
#     users POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user GET    /users/:id(.:format)      users#show
#           PATCH  /users/:id(.:format)      users#update
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy
#      root GET    /                         home#top

  get "/login" => "users#login_form"
  post "/login" => "users#login"
  post "/logout" => "users#logout"
  resources :users, only: [:show, :new, :create, :edit, :update]

  root "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
