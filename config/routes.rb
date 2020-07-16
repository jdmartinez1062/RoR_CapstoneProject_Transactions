Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, only: %i[show]
  post '/groups/new', to: 'groups#create'
  resources :groups, except: %i[destroy update edit create]
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'user/:id/grouptimes', to: 'user#user_times', as: 'user_times'
  get 'user/:id/externaltimes', to: 'user#external', as: 'external_times'
  get 'group/:id/times', to: 'group#group_times', as: 'group_times'
end
