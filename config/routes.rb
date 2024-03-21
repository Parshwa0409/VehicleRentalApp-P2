Rails.application.routes.draw do
  devise_for :users

  # ADMIN ROUTES
  # VEHICLES
  get "admin/vehicles", to:"admin#show_vehicles"
  get "admin/new_vehicle", to:"admin#new_vehicle"
  post "admin/new_vehicle", to:"admin#create_vehicle"
  get "admin/search_vehicle", to: "admin#show_vehicles"
  post "admin/search_vehicle", to:"admin#search_vehicle"
  get "admin/edit_vehicle", to:"admin#edit_vehicle"
  post "admin/update_vehicle", to:"admin#update_vehicle"
  delete "admin/destroy_vehicle", to:"admin#destroy_vehicle"

  # RENTAL AGREEMENT
  get "admin/insights", to: "admin#rental_insights"

  # USERS / CUSTOMERS
  get "admin/customers", to:"admin#customers"
  get "admin/search_customer", to:"admin#customers"
  post "admin/search_customer", to:"admin#search_customer"

  # USER _ MODEL
  get 'active_agreement', to:'user#active'
  post 'end_active_agreement', to:'user#return_car'
  get 'all_agreements', to: 'user#all_agreements'
  post "user_can_rent", to: "user#can_rent"
  
  # VEHICLE _ MODEL
  get "/vehicles", to: "vehicle#show"
  get "/search_vehicle", to: "vehicle#show"
  post "/search_vehicle", to: "vehicle#search_vehicle"
  
  # RENTAL AGREEMENT _ MODEL
  get "new_agreement", to:"rental_agreement#new"
  post "new_agreement", to:"rental_agreement#create"
  get 'agreement_detail', to: 'rental_agreement#detail'

  root 'home#index'

  get 'user/profile', to: 'user#show'

  get "up" => "rails/health#show", as: :rails_health_check
end
