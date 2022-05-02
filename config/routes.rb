Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#homepage'
  
  resources :exercises
  get '/homepage', to: 'home#homepage'
  resources :users
  
end
