Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'actors#index'

  resources :users

  resources :actors do
    resources :reviews, only: [:new, :create, :index]
  end

  resources :reviews, except: [:new, :create, :index] do
    resources :votes, only: [:new, :create, :index]
  end

  resources :votes, except: [:new, :create, :index]
end
