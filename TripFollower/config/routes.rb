TripFollower::Application.routes.draw do

  root to: 'sessions#new'
  resources :users
  resources :trips, except: [:index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :destinations do
    get "photo", :as => "photo"
  end

  match '/signout', to: 'sessions#destroy'

end