Rails.application.routes.draw do

  root 'home#index'
  resources :friendships
  resources :sessions, only: [:new, :create]
  resources :users
  delete 'log_out' => 'sessions#destroy'

  resources :messages do
    collection do
      get :sent
      get :received
    end
  end

  resources :messages

  # get 'sign_in' => 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
