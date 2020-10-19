Rails.application.routes.draw do
  root to: 'pages#home'

  resources :reports, only: [:create, :index, :new]
end
