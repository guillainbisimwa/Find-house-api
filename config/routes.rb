Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :houses
  resources :favourites
  api_guard_routes for: 'users'

end
