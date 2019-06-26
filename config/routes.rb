Rails.application.routes.draw do
  devise_for :users
  
  root to: "devices#index"
  
  resources :devices do
    resources :notifications do
      resources :subscriptions, only: [:create, :destroy]
    end
  end
end
