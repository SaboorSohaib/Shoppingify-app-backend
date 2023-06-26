Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users
    resources :lists, only: [:index, :show, :create, :update, :destroy] do
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get :top_items
          get :top_categories
        end
      end
    end
  resources :categories, only: [:index, :create]
end
