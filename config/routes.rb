Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :dashboard, only: [:show]

  scope '/dashboard' do
    root 'dashboards#show'
  end
end
