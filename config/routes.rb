Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :dashboard, only: [:index, :show]

  root 'posts#index'

  resources :posts do
    resources :comments
  end

  resources :friendships, only: [:new, :create, :destroy]
  resources :friend_requests, only: [:index, :new, :create, :destroy]
end
