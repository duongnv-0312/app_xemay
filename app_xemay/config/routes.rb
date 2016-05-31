Rails.application.routes.draw do
  post "/rate" => "rater#create", :as => "rate"
  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}
  root "reviews#index"
  get "maps/index"
  post "maps/index"

  namespace :admin do
    resources :users
    resources :reviews do
      resources :comments
      collection do
        match "search" => "reviews#search", via: [:get, :post], as: :search
      end
    end
  end

  resources :users, only: [:show] do
    collection do
      get :markings
    end
  end
  resources :reviews, only: [:show, :index] do
    resources :comments
    collection do
      match "search" => "reviews#search", via: [:get, :post], as: :search
    end
  end
  resources :marked_reviews, only: [:create, :destroy]
end
