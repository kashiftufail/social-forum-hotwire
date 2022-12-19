Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :forum_discussions , only: [:index]
  # Defines the root path route ("/")
  root "home#index"
end
