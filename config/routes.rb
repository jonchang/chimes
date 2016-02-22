Rails.application.routes.draw do

  root 'pages#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy', as: 'signout'

end
