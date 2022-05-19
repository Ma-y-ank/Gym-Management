Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  
  resources :exercises do
    member do
      patch 'toggle_favourite'
      patch 'change_status'
    end
  end

  resources :exercises do
    collection do
      post 'import'
    end
  end

  get '/home', to: 'home#home'
  
  resources :users do 
    member do 
      patch 'manage_exercises'
      get 'start_set'
    end
  end  
  # patch 'exercises/:id/toggle_favourite', to: 'exercises#toggle_favourite', as: 'toggle_favourite'
end
