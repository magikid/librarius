Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/failure'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "welcome/index"
  root "welcome#index"

  resources :books

  get   'login', to: redirect('/auth/github'), as: 'login'
  get   '/auth/:provider/callback', :to => 'sessions#create'
  get   'logout', :to => 'sessions#destroy', as: 'logout'


  resources :authors, only: [:index]
end
