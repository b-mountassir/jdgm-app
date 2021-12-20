Rails.application.routes.draw do
  root 'pages#index'
  get "about", to: "pages#aboutUs"
  get "contact", to: "pages#contactUs"
  get "/search", to: "movies#search"
  resources :movies, only: [:index, :show] do
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
