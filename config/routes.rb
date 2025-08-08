# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'

  # Staff routes
  namespace :staff do
    resources :companies
    resources :users
    get 'switch_company/:id', to: 'companies#switch', as: 'switch_company'
  end

  # Main application routes
  resources :animals do
    member do
      get 'qr_code', defaults: { format: 'png' }
    end
    resources :vaccinations, except: [:index]
  end

  resources :vaccinations, only: [:index]
  resources :companies, only: [:show, :edit, :update]
  
  # Public vaccination view (via QR code)
  get 'public/animal/:id/vaccinations', to: 'public#animal_vaccinations', as: 'public_animal_vaccinations'

  # PWA routes
  get 'manifest', to: 'application#manifest', defaults: { format: 'json' }
  get 'service-worker', to: 'application#service_worker', defaults: { format: 'js' }
end
