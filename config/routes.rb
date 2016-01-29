Rails.application.routes.draw do
  resources :dashboards, only: :show
  devise_for :users
  root 'home#index'
  resources :jobs, only: [:show, :new, :create, :edit, :update]
  resources :companies, only: [:new, :create, :show, :edit, :update]
  resources :categories, only: [:new, :create, :show]
  resources :hiring_types, only: :show
end
