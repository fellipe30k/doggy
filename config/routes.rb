# config/routes.rb - Corrigido
Rails.application.routes.draw do
  devise_for :users
  root "dashboard#index"

  # Staff routes
  namespace :staff do
    resources :companies do
      member do
        get "switch"
      end
    end
    resources :users
    get "switch_company/:id", to: "companies#switch", as: "switch_company"
  end

  # Main application routes
  resources :animals do
    member do
      get "qr_code", defaults: { format: "png" }
    end
    resources :vaccinations, controller: "animals/vaccinations", except: [ :index ]
  end

  resources :vaccinations
  resources :companies, only: [ :show, :edit, :update ]
  resources :owners
  
  # Public vaccination view (via QR code)
  get "public/animal/:id/vaccinations", to: "public#animal_vaccinations", as: "public_animal_vaccinations"

  # PWA routes
  get "manifest", to: "application#manifest", defaults: { format: "json" }
  get "service-worker", to: "application#service_worker", defaults: { format: "js" }
end
