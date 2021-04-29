Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'my_dashboard', to: 'pages#my_dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :swaps, only: [:show] do
    resources :messages, only: [:create]
  end

  resources :products do
    resources :swaps, only: [:new, :create]
  end
end
