Ourgists::Application.routes.draw do
  root :to => "sessions#new"

  resource :session, :only => [:new, :create, :destroy]
  resources :gists do
    resource :favorite, :only => [:create, :destroy]
  end
  resources :users
end
