Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root to: 'homes#index'
  resources :questions do
    resources :answers
  end
end
