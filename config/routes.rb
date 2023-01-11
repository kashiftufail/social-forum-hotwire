Rails.application.routes.draw do
  resources :categories
  # get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :discussions , only: [:index, :create, :new, :edit, :update,:destroy,:show] do
  
    resources :articles, only: [:create, :show, :edit, :update, :destroy] , module: :discussions

  end
  
  # Defines the root path route ("/")
  root "home#index"
end
