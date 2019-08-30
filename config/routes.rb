Rails.application.routes.draw do
  root "top#index"
  get 'home/about' => "top#about"
  devise_for :users
  resources :books
  resources :users
end
