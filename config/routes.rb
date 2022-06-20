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

  get "lists", to:"home#lists"
  get "feed", to:"home#feed"
  get "influencers", to: 'users#influencers'
  get "enterpreneurs", to: 'users#enterpreneurs'
  get "projects", to: 'users#projects'

  root "home#index"
end
