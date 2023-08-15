Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'items/top_item', to: 'items#top_item'
  get 'items/top_categories', to: 'items#top_categories'
  get 'lists/deactivate', to: 'lists#deactivate'

  resources :users
    resources :lists, only: [:index, :show, :create, :update, :destroy, :deactivate] 

  resources :categories, only: [:index, :create] do 
    resources :items, only: [:index, :show, :create, :update, :destroy]
  end 
end
