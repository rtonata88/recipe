Rails.application.routes.draw do
  resources :foods

  devise_for :users
  resources :recipes
  resources :recipe_foods

  post '/add-ingredient', to: "recipes#add_ingredient"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#index"
end
