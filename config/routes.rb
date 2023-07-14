Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations',
    sessions: 'sessions'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  delete 'logout', to: 'sessions#destroy', as: :logout

  resources :contacts
  get '/search-address/:cep', to: 'addresses#search_address'
end
