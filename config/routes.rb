Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :dashboard, only: [:show]

  root 'dashboard#show'
end
