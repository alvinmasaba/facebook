Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :dashboard, only: [:show]

  root 'dashboards#show'

  resources :posts do
    resources :comments
  end

  resources :friendships, only: [:new, :create, :destroy]
end
