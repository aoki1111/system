Rails.application.routes.draw do

  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/company', to: 'static_pages#company'
  get '/privacy', to: 'static_pages#privacy'
  get '/dashboard', to: 'static_pages#dashboard'
  get '/shipments', to:'static_pages#shipments'
  get '/introducing', to: 'static_pages#introducing'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/shipments/orders/pickup', to: 'orders#pickup'
  resources :users, :except => [:new,:create]
  resources :account_activations, only: [:edit]
  resources :events, path: 'shipments/events'
  resources :stocks, path: 'shipments/stocks'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :orders, path: 'shipements/orders'
end
