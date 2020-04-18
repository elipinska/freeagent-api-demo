Rails.application.routes.draw do
  devise_for :users
  namespace :freeagent_api do
    resources :requests do
      member do
        get :results
      end
    end
  end
  get "/auth/freeagent/callback", to: "freeagent_api/authentications#create"
  root "freeagent_api/authentications#new"

  namespace :freeagent_api do
    resources :authentications, only: [:show, :new, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
