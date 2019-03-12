Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/failure'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "welcome/index"
  root "welcome#index"

  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  resources :books

  resources :authors, only: [:index]
end
