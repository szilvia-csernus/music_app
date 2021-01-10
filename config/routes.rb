Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:create, :new, :destroy]
  
  resources :users, only: [:create, :new, :show] do
    collection do
      get 'activate'
    end
  end

  resources :users, only: :index do
    member do
      get 'flip_admin_rights'
    end
  end
  
  resources :bands do
    resources :albums, only: [:new]
    resources :tags, only: [:create, :destroy]
  end
  
  resources :albums, only: [:create, :show, :edit, :update, :destroy]
  
  resources :albums, only: :show do
    resources :tracks, only: :new
    resources :tags, only: [:create, :destroy]
  end
  
  resources :tracks, only: [:create, :edit, :update, :destroy]

  resources :tracks, only: :show do
    resources :tags, only: [:create, :destroy]
  end
  
  resources :notes, only: [:create, :destroy]

  root to: 'bands#index'
end
