Rails.application.routes.draw do
  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}

  namespace :admin do
    resources :users
    resources :reviews
  end

  resources :users
  resources :reviews do
    resources :comments
  end
end
