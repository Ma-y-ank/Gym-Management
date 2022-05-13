Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#homepage'
  
  resources :exercises do
    member do
      patch 'change_favourite'
      patch 'change_status'
    end
  end

  resources :exercises do
    collection do
      post 'import'
    end
  end

  get '/homepage', to: 'home#homepage'
  
  resources :users do 
    member do 
      patch 'manage_exercises'
      get 'start_exercise'
    end
  end

  resources :diets
  
  # patch 'exercises/:id/change_favourite', to: 'exercises#change_favourite', as: 'change_favourite'
end
