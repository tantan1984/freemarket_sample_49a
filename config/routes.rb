Rails.application.routes.draw do
  devise_for :users
  root 'top#index' # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :top, only: :index, defaults: { format: 'json' }
  end
  resources :users, only: [:index]
  resources :signup, only: [:index]
  resources :phone_number_authorization, only:[:new]
  resources :address_registration, only:[:new]
  resources :credit_card, only:[:new]
  resources :user_identifications, only: [:index]
  resources :user_profile, only:[:new]
  resources :products, only:[:show, :new, :edit] do
    collection do
      get 'buy'
    end
    resources :category
  end
end

