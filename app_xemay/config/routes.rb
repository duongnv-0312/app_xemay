Rails.application.routes.draw do
  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}
  root "reviews#index"
  get "static_pages/index"

  namespace :admin do
    resources :users
    resources :reviews
  end

  resources :users
  resources :reviews do
    resources :comments
  end
end
