Rails.application.routes.draw do
  root to: 'pages#home'

  resources :reports, only: [:create,:new, :show]
  resources :items, only: [:index]
end
