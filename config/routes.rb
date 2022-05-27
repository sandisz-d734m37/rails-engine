Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/v1/merchants/find", to: "api/v1/merchants#find"
  get "/api/v1/merchants/find_all", to: "api/v1/merchants#find_all"
  get "/api/v1/items/find", to: "api/v1/items#find"
  get "/api/v1/items/find_all", to: "api/v1/items#find_all"
  get "/api/v1/merchants/:merchant_id/items", to: "api/v1/merchant_items#index"
  get "/api/v1/items/:item_id/merchant", to: "api/v1/merchant_items#show"

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_items, only: [:index]
      end
      resources :revenue, only: [:index]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:show, :create, :index, :update, :destroy]
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        resources :items, only: [:index]
      end
    end
  end
end
