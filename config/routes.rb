Rails.application.routes.draw do
  get 'articles/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # get "oauth/logout" => "oauth#logout", as: :logout

  resources :articles do
    resources :comments
    resources :likes
  end
  resources :users
  resources :projects
  resources :sessions do
    collection do
      get "logout"
      get "login"
    end
  end

  get "lists", to:"home#lists"
  get "articles", to:"home#articles"
  get "influencers", to: 'users#influencers'
  get "enterpreneurs", to: 'users#enterpreneurs'
  # get "projects", to: 'users#projects'

  root "home#index"
end
