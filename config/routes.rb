Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root "target_sites#index", as: :root

  resources :target_sites, only: %i( index show create )
  resources :target_pages, only: %i( create )

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
