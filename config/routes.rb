Rails.application.routes.draw do
  devise_for :users
  get '/', action: :index, controller: 'events'
  resources :events, only: [:new, :create, :show]
end