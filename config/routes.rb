Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#homepage'
  
  resources :exercises do
    member do
      patch 'change_favourite'
    end
  end

  get '/homepage', to: 'home#homepage'
  
  resources :users do 
    member do 
      patch 'manage_exercises'
    end
  end
  
  # patch 'exercises/:id/change_favourite', to: 'exercises#change_favourite', as: 'change_favourite'
end
