Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
get '/me', to: 'users#show'
resources :user, only: [:create]
resources :sessions, only: [:create, :destroy]
post '/login', to: 'sessions#create'
post '/signup', to: 'users#create'
delete '/logout', to: 'sessions#destroy'


end