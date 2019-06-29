Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :devices, only: [:create] do
        resources :measures, only: [:create]
      end
    end
  end

  resources :devices, only: [:index] do
    resources :measures, only: [:index]
  end

  resources :notifications, only: [:update]
  
  resources :sessions, only: [:new, :create, :destroy]

  root 'devices#index'
end
