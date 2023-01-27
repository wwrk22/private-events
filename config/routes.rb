Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"

  resources :events

  # Devise User
  devise_scope :user do
    get 'my_info', to: 'users/sessions#show'
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
