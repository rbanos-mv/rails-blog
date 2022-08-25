Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[create destroy index new show] do
      resources :comments, only: %i[create destroy new]
      resources :likes, only: %i[create]
    end
  end
end
