Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root "target_sites#index", as: :root

  resources :target_sites, only: %i( index show create )
  resources :target_pages, only: %i( create ) do
    post '/crawl_methods', to: 'target_pages#add_crawl_method', on: :member
  end

  resources :ads, only: %i( show update )
end
