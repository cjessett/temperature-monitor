Rails.application.routes.draw do
  resources :devices do
    resources :notifications do
      resources :subscriptions, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
