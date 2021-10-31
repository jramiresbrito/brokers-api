Rails.application.routes.draw do
  resources :assets, only: %i[index show]

  resources :brokers, only: %i[create show] do
    collection do
      get 'me'
    end
  end

  resources :sign_in, only: :create
  post '/password_reset', to: 'password_reset#create'
  post '/password_update', to: 'password_update#create'
end
