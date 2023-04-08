Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'user_sessions#login_as', as: :login_as
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  delete 'logout', to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]
  resources :users, only: %i[new create show edit update destroy] do
    resource :follows, only: [:create, :destroy]
    get 'add_published', on: :collection
    get 'remove_published', on: :collection
  end
  resources :fishes do
    get :complete, on: :collection
    get :complete_edit, on: :collection
    get :ajax_current_weather, on: :collection
    post :ajax_history_weather, on: :collection
    resources :comments, only: %i[create edit update destroy], shallow: true
  end
  resources :likes, only: %i[create destroy]
  namespace :mypage do
    get 'dashboard'
    get 'follows'
    get 'followers'
    get 'notifications'
  end
end
