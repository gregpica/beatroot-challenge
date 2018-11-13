Rails.application.routes.draw do
  root 'tracks#index'

  resources :tracks, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :tracks, only: [:index, :show]
    end
  end
end
