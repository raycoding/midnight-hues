Rails.application.routes.draw do
  root :to => 'spongebob#index'
  resources :users
  get 'register' => 'users#new', :as=>'register'
  get 'logout' => 'user_sessions#destroy', :as=>'logout'
  get 'login' => 'user_sessions#new', :as=>'login'
  resources :user_sessions, :only=>[:create]
end