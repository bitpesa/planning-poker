Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :poker_sessions, only: :create
  resources :estimates, only: :create
end
