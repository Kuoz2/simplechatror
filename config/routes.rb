Rails.application.routes.draw do
  post 'add/user', to: 'rooms#add_user'
  resources :rooms do 
    resources :messages
    member do 
      post 'add_user', to: 'rooms#add_user'
      delete 'remove_user', to: 'rooms#remove_user'
      patch :complete

    end
  end
  root 'rooms#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
