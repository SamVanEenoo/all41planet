Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # get "oauth/logout" => "oauth#logout", as: :logout

  resources :users
  resources :sessions do
    collection do
      get "logout"
      get "login"
    end
  end

  root "home#index"
end
