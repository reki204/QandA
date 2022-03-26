Rails.application.routes.draw do
  root to: 'homes#index'
  resources :questions do
    # resources :answers
  end
end
