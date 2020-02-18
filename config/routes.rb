Rails.application.routes.draw do
  get '/', action: :index, controller: 'home'
end