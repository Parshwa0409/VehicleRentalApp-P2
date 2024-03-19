Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'user/profile', to: 'user#show'

  get "up" => "rails/health#show", as: :rails_health_check
end
