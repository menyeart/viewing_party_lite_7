Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "landing#index"

  resources :users, only: [:show, :new, :create] do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show] do
      resources :viewing_party, only: %i[new create]
      resources :viewing_party_user, only: [:create]
    end
  end

  get "/register", to: "users#new"
  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"
end
