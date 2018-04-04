Rails.application.routes.draw do

  resources :users
  resources :sessions
  resources :microposts, only: [:create, :destroy]

  root to: 'static_pages#home'
  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/users' => 'users#create'
  # get '/signin', to: 'sessions#new'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
