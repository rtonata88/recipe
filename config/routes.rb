Rails.application.routes.draw do

  devise_for :users
  resources :recipes
  resources :recipe_foods

  post '/add-ingredient', to: "recipes#add_ingredient"
  get '/shopping_list/:recipe_id', to: "recipes#shopping_list"
  get '/foods/new(/:recipe_id)', to: 'foods#new'

  resources :foods
  resources :recipes
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#index"
end
