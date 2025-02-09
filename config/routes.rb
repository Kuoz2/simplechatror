Rails.application.routes.draw do
  resources :task_flows, only: [:index]
  get 'reports/worker_efficiency', to: 'reports#worker_efficiency', as: 'worker_efficiency_report'
  get 'reports/report_view', to: 'reports#report_view', as: 'report_view'
  resources :reports, only:[:index, :show, :create, :update]
  devise_for :users, controllers: {
    registrations: 'users/registrations' ,
    sessions: 'users/sessions'
  }
  namespace :admin do
    resources :registrations, only: [:new, :create]
  end
  post 'add/user', to: 'rooms#add_user'
  resources :rooms do 
    resources :messages
    member do 
      post 'add_user', to: 'rooms#add_user'
      delete 'remove_user', to: 'rooms#remove_user'
      patch :complete
    end
    collection do 
      get "graficos"
    end
    collection do 
      get 'dashboard'
    end
  end
  root 'rooms#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
