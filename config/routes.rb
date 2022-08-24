Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[create index new show] do
      resources :comments, only: %i[create new]
      resources :likes, only: %i[create]
    end
  end
end
