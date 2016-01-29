Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create, :update, :show]
    resources :items, only: [:create, :update, :show, :destroy]
  end
end
