Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'my_dashboard', to: 'pages#my_dashboard'

  patch 'swaps/:id/reject', to: 'swaps#mark_as_rejected', as: :reject_swap
  get 'swaps/:id/choose_item', to: 'swaps#choose_item', as: :choose_item_to_swap
  patch 'swaps/:id/accept', to: 'swaps#mark_as_accepted', as: :accept_swap

  get 'faq', to: 'pages#faq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :swaps, only: [:show] do
    resources :messages, only: [:create]
  end

  resources :products do
    resources :swaps, only: [:create]
  end
end
