Rails.application.routes.draw do

  root 'pages#index'

  get 'test', to: 'pages#test'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy', as: 'signout'

  resources :conferences
  resources :rooms

end
