Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, only: %i[show]
  resources :groups, except: %i[destroy update edit]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
