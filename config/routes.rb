Rails.application.routes.draw do
  resources :target_sites, only: %i( index show create )
  resources :target_pages, only: %i( create )

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
