Rails.application.routes.draw do

  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/company', to: 'static_pages#company'
  get '/privacy', to: 'static_pages#privacy'
  get '/dashboard', to: 'static_pages#dashboard'
  get '/search_unship_order', to: 'static_pages#search_unship_order'
  get '/shipments', to:'static_pages#shipments'
  get '/introducing', to: 'static_pages#introducing'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/shipments/stocks/complete', to: 'stocks#complete'
  resources :users, :except => [:new,:create]
  resources :account_activations, only: [:edit]
  resources :stocks, path: 'shipments/stocks'
  resources :postages, path: 'shipments/postages'
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :middle_boxes, only: [:edit, :update]
  resources :few_item_boxes,  only: [:edit, :update]

  namespace :admin do
      resources :users
      resources :stocks
      resources :postages
  end
end
