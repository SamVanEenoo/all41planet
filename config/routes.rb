Rails.application.routes.draw do
  get 'articles/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # get "oauth/logout" => "oauth#logout", as: :logout

  resources :articles do
    resources :comments
    resources :likes
  end
  resources :companies
  resources :enterpreneurs
  resources :members
  resources :projects
  resources :users
  resources :sessions do
    collection do
      get "logout"
      get "login"
    end
  end

  get "lists", to:"home#lists"

  root "home#index"
end
