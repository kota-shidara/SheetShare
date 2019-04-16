Rails.application.routes.draw do

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#delete"

  resources :users, only: [:show, :new, :create, :edit, :update] do
    member do
      get 'sales'
    end
  end

  resources :sales, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get 'step'
      patch 'append'
      get 'check'
      post 'confirm'
      get 'complete'
    end
  end

  resources :purchases, only: [:index] do
    collection do
      get 'step1'
      get 'step2'
      post 'confirm'
      get 'thanks'
    end
  end

  root "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end