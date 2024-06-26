Rails.application.routes.draw do
  root "movies#index"
  get '/movies', to: 'movies#index'
  get "/movies/show/:id", to: 'movies#show'
  get "/movies/search", to: 'movies#search'
  get "/movies/genre/:genre", to: 'movies#genre'
  get "/movies/lists/:list", to: 'movies#lists'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
