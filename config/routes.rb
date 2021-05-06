Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :users, only: [:show] do
    resources :reviews, only: [ :new, :create ]
  end
  root to: 'pages#home'
  get 'my_dashboard', to: 'pages#my_dashboard'

  patch 'swaps/:id/reject', to: 'swaps#mark_as_rejected', as: :reject_swap
  get 'swaps/:id/choose_item', to: 'swaps#choose_item', as: :choose_item_to_swap
  patch 'swaps/:id/accept', to: 'swaps#mark_as_accepted', as: :accept_swap
  patch 'swaps/:id/exchanged', to: 'swaps#mark_as_exchanged', as: :exchanged_swap
  patch 'swaps/:id/canceled', to: 'swaps#mark_as_canceled', as: :canceled_swap
  patch 'swaps/:id/mark_messages_as_read', to: 'swaps#mark_messages_as_read'

  get 'faq', to: 'pages#faq'
  get 'team', to: 'pages#team'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :swaps, only: :show do
    resources :messages, only: :create
  end

  resources :products do
    resources :swaps, only: [:create]
  end

  get 'swaps/:id/choose_item/products/:product_id', to: 'swaps#info', as: :product_info
end
