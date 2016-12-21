Rails.application.routes.draw do

  root 'pages#index'

  get '/test', to: 'pages#test'

  get '/live/:id', to: 'pages#conference'
  get '/live/r/:id', to: 'pages#room'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy', as: 'signout'

  resources :conferences
  resources :rooms do
    member do
      get :clone
      get :events_json
      post :add_event_type
      post :add_event
      post :clone_day
    end
  end
  resources :events
  resources :event_types

end
