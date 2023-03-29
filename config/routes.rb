Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'user_sessions#login_as', as: :login_as
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :password_resets, only: %i[new create edit update]
  resources :users, only: %i[new create show edit update] do
    get 'add_published', on: :collection
    get 'remove_published', on: :collection
  end
  resources :fishes do
    get :complete, on: :collection
    get :complete_edit, on: :collection
    get :ajax_current_weather, on: :collection
  end
  resources :likes, only: %i[create destroy]
  namespace :mypage do
    get 'dashboard'
    get 'follow'
    get 'follower'
  end
end
