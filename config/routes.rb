Rails.application.routes.draw do
	mount ActionCable.server => '/cable'

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
	resources :users, :except => [:new,:create]
	resources :account_activations, only: [:edit]
	resources :stocks, path: 'shipments/stocks'
	post '/shipments/stocks/complete', to: 'stocks#complete'
	resources :postages, path: 'shipments/postages'
	resources :password_resets, only: [:new, :create, :edit, :update]
	resources :users, shallow: true do
		resources :rooms, shallow: true do
			resources :messages
		end
	end


	namespace :admin do
		resources :postages, :stocks,:items
		resources :users, shallow: true do
			resources :order_products, :rooms
		end
		get 'order_products/update_shipment_week/:farmer_id', to: 'order_products#update_shipment_week'
	end
	get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
