Rails.application.routes.draw do
  devise_for :users
  devise_for :installs
  root to: "messages#index"
end

