Rails.application.routes.draw do
  get 'messages/show'

  root 'static_pages#home'
  resources :users
  resources :chatrooms
  resources :messages
  resources :account_activation, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 	 '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get 	 '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
