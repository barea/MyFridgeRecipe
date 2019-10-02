Rails.application.routes.draw do
  devise_for :users
  resources :ingredients
  root to: 'recipes#searchbyingt'
  resources :recipes do 
  	collection do 
  		get :searchbyingt
  	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
end