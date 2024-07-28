Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [] do
    resources :diaries
  end

   root 'homes#index'

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
