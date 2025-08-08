# app/controllers/public_controller.rb
class PublicController < ApplicationController
  skip_before_action :authenticate_user!, only: [:animal_vaccinations]
  before_action :authenticate_user!, only: [:animal_vaccinations]

  def animal_vaccinations
    @animal = Animal.find(params[:id])
    @vaccinations = @animal.vaccinations.recent
    
    # Verificar se o usuário é o dono ou tem acesso
    unless current_user.owner? || current_user.company_id == @animal.company_id
      redirect_to root_path, alert: 'Acesso negado.'
    end

    render layout: 'public'
  end
end