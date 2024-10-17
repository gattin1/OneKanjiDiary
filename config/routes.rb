# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :users, only: [] do
    resources :diaries do
      get 'mood_statistics', on: :collection
    end
    get 'reminder_settings', on: :member
    patch 'update_reminder_time', on: :member
  end

  get 'images/ogp.png', to: 'images#ogp', as: 'images_ogp'

  root 'homes#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
