Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: [:index, :show] do
    get '/friends', to: 'users#friends', as: :friends
  end

  resource :dashboard, only: [:index, :show]

  root 'posts#index'

  concern :likeable do
    resources :likes, only: [:new, :create, :destroy]
  end

  resources :posts, concerns: :likeable do
    resources :comments, concerns: :likeable
  end

  resources :friendships, only: [:new, :create, :destroy]
  resources :friend_requests, only: [:index, :new, :create, :destroy]
end
