Rails.application.routes.draw do
  resources :categories
  # get 'home/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :discussions , only: [:index, :create, :new, :edit, :update,:destroy,:show] do
  
    resources :articles, only: [:create, :show, :edit, :update, :destroy] , module: :discussions
    
    

    collection do
      get 'category/:id', to: "categories/discussions#index", as: :category
      post 'create_likes', to: "discussions#like_dislike" ,as: :like_dislike 
      post 'create_votes', to: "discussions#vote_up_down" ,as: :vote_up_down
    end

    resources :notifications, only: :create, module: :discussions

    

  end

  
  resources :search, only: [:create] 

  resources :notifications, only: :index do
    collection do
      post '/mark_as_read', to: "notifications#read_all", as: :read
    end
  end
  
  # Defines the root path route ("/")
  root "home#index"
end
