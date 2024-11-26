Rails.application.routes.draw do
  #resources :profiles
  resources :posts

  resources :posts do
    resources :comments, only: [:create], defaults: { commentable: 'Post' }
  end
  # resources :guides do
  #   resources :comments, only: [:create], defaults: { commentable: 'Guide' }
  # end
  # resources :snippets do
  #   resources :comments, only: [:create], defaults: { commentable: 'Snippet' }
  # end
  
  # devise_for :users #default
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'   
  }

# Nested profile routes under users
resources :users, only: [] do
  resource :profile, only: [:show, :edit, :update]
end  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
