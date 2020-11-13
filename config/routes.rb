Rails.application.routes.draw do
  
  root to: 'toppages#index'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:show, :new, :create] do
    member do
      get :groupsshow
    end
  end
  resources :groups, only: [:index, :show, :new, :create, :destroy]
  resources :posts, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
