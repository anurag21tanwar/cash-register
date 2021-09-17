# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index]
      resources :basket, only: [:show]
      resources :items, only: %i[create destroy] do
        member do
          post :add
          post :sub
        end
      end
    end
  end

  root 'homepage#index'
  get '/*path' => 'homepage#index'
end
