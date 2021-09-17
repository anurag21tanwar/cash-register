Rails.application.routes.draw do
  root 'homepage#index'

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
    end
  end
end
