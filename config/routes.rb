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
  resources :time_spents, only: %i[new show]
  post 'time_spents/new', to: 'time_spents#create'
  get 'user/:id/grouptimes', to: 'users#user_times', as: 'user_times'
  get 'user/:id/externaltimes', to: 'users#external_times', as: 'external_times'
  get 'group/:id/times', to: 'groups#group_times', as: 'group_times'
end
