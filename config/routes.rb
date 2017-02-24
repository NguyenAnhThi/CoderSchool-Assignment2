Rails.application.routes.draw do
  root 'home#index'
  resources :sessions, only: [:new, :create]
  resources :users
  delete 'log_out' => 'sessions#destroy'

  # get 'sign_in' => 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
