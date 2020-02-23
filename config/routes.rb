Rails.application.routes.draw do
  devise_for :users
  get '/', action: :index, controller: 'events'
  resources :events, only: [:new, :create, :show] do 
    resources :attendances, only: [:new, :create, :index]
  end

  get 'tags/:tag', to: 'events#index', as: :tag
end