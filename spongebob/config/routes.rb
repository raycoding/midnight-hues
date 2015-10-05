Rails.application.routes.draw do
  root :to => 'spongebob#index'
  resources :users
  get 'logout' => 'user_sessions#destroy', :as=>'logout'
  get 'login' => 'user_sessions#new', :as=>'login'
  resources :user_sessions, :only=>[:create]
end