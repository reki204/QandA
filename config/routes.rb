Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'
  resources :users
  resources :questions do
    resources :answers
  end
end