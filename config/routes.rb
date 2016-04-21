Rails.application.routes.draw do
  devise_for :users
  get '/' => 'home#index'
  get '/' => 'home#index'

  post '/users/signup' => 'users#signup'
  post '/sessions/login' => 'sessions#login'

  get '/users/profile' => 'users#profile'
  get '/users/new_pack' => 'users#newPack'

end
