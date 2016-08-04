Rails.application.routes.draw do

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments 
  end
  
  root 'pages#home'

  scope :pages, controller: :pages do
    get 'about'
    get 'portfolio'
    get 'contacts'
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  get "users/new"
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
