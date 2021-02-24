Rails.application.routes.draw do
  root 'static_pages#home'
  # root 'home#index'

  devise_for :users


  devise_scope :user do
    get    '/login',  to: 'devise/sessions#new'
    post   '/login',  to: 'devise/sessions#new'
    delete '/logout', to: 'devise/sessions#destroy'
  end

  # get 'sessions/new'
  # get 'users/new'
  # get '/signup', to:'users#new'
  # get    '/login',   to: 'sessions#new'
  # post   '/login',   to: 'sessions#create'
  # delete '/logout',  to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers, :worklikes, :voicelikes
    end
  end

  resources :works do
    resources :voices, only: [:create]
  end
  resources :voices, only: [:index, :show, :destroy]

  resources :voices do
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]

  resources :relationships, only: [:create, :destroy]

  post 'worklike/:id' => 'work_likes#create', as: 'create_worklike'
  delete 'worklike/:id' => 'work_likes#destroy', as: 'destroy_worklike'

  post 'voicelike/:id' => 'voice_likes#create', as: 'create_voicelike'
  delete 'voicelike/:id' => 'voice_likes#destroy', as: 'destroy_voicelike'
end