
Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end
  resources :messages, only: [:new, :index, :create]
  get '/thank_you' => 'static_pages#thank_you'
  get '/my-messages' => 'static_pages#my_messages', as: :my_messages
  root to: 'static_pages#index'

end
