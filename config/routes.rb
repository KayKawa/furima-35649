Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

  resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :items, only: [:show] do
    resources :purchases, only: [:index, :create]
  end
end
