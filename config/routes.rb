Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/v1/merchants/:merchant_id/items", to: "api/v1/merchant_items#index"
  get "/api/v1/items/:item_id/merchant", to: "api/v1/merchant_items#show"
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:show, :create, :index, :update, :destroy]
    end
  end
end
