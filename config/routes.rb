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
  


  root 'home#index'

  get 'user/profile', to: 'user#show'

  get "up" => "rails/health#show", as: :rails_health_check
end
