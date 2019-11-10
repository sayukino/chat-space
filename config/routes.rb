Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"

  resources :groups do
     resources :messages,only:[:index, :create, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
     resources :users,only:[:edit, :show, :update]
  end  

