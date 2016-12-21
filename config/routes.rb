Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  resources :contacts, only: :create
end
