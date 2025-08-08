# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_company
  before_action :check_user_active

  def manifest
    render json: {
      name: 'Doggy - Controle de Vacinação',
      short_name: 'Doggy',
      description: 'Sistema de controle de vacinação para animais',
      start_url: '/',
      display: 'standalone',
      theme_color: '#1f2937',
      background_color: '#111827',
      icons: [
        {
          src: '/icon-192.png',
          sizes: '192x192',
          type: 'image/png'
        },
        {
          src: '/icon-512.png',
          sizes: '512x512',
          type: 'image/png'
        }
      ]
    }
  end

  def service_worker
    render js: <<~JS
      const CACHE_NAME = 'doggy-v1';
      const urlsToCache = [
        '/',
        '/assets/application.css',
        '/assets/application.js'
      ];

      self.addEventListener('install', function(event) {
        event.waitUntil(
          caches.open(CACHE_NAME)
            .then(function(cache) {
              return cache.addAll(urlsToCache);
            })
        );
      });

      self.addEventListener('fetch', function(event) {
        event.respondWith(
          caches.match(event.request)
            .then(function(response) {
              if (response) {
                return response;
              }
              return fetch(event.request);
            }
          )
        );
      });
    JS
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :role, :company_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone])
  end

  def set_current_company
    return unless user_signed_in?
    
    if current_user.staff? && params[:company_id].present?
      session[:staff_company_id] = params[:company_id]
    end
    
    @current_company_id = current_user.staff? ? session[:staff_company_id] || current_user.company_id : current_user.company_id
  end

  def check_user_active
    if user_signed_in? && !current_user.active?
      sign_out current_user
      redirect_to new_user_session_path, alert: 'Sua conta foi desativada. Entre em contato com o administrador.'
    end
  end

  def ensure_staff!
    redirect_to root_path, alert: 'Acesso negado.' unless current_user&.staff?
  end

  def ensure_admin_or_staff!
    redirect_to root_path, alert: 'Acesso negado.' unless current_user&.can_manage_company?
  end

  def ensure_same_company!(resource)
    unless current_user.staff? || resource.company_id == @current_company_id
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end

  def filter_by_company(scope)
    current_user.staff? ? scope : scope.by_company(@current_company_id)
  end
end