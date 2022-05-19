Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/api/v1/merchants/:merchant_id/items", to: "api/v1/merchant_items#index"
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] #do
        # resources :items, only: [:index]
      # end
      resources :items, only: [:show, :create, :index, :update, :destroy]
    end
  end
end
