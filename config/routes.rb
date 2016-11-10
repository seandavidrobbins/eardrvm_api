Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, except: :new do
    resources :albums, only: [:index, :create, :update, :destroy]

    collection do
      post '/login', to: 'users#login'
    end
  end
  resources :albums, only: [:show] do
    resources :songs, only: [:index, :create]
  end
  resources :songs, only: [:show, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
  end

  resources :songs, only: [:create, :destroy]
end
