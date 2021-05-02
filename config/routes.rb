Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :houses

  api_guard_routes for: 'users'

  resources :users do
    resources :favourites
  end

  post 'auth/login', to: 'authentication#authenticate'


end
