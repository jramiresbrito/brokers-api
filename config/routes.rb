Rails.application.routes.draw do
  resources :owned_assets, only: %i[index show]
  resources :assets, only: %i[index show]
  resources :bids, only: %i[index create show]
  post '/buy', to: 'bids#buy'
  post '/sell', to: 'bids#sell'

  resources :brokers, only: %i[create show] do
    collection do
      get 'me'
    end
  end

  resources :sign_in, only: :create
  post '/password_reset', to: 'password_reset#create'
  post '/password_update', to: 'password_update#create'
end
