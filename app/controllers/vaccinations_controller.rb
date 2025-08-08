# Correção no app/controllers/vaccinations_controller.rb
class VaccinationsController < ApplicationController
  before_action :set_vaccination, only: %i[show edit update destroy]
  before_action :ensure_same_company!, only: %i[show edit update destroy]

  def index
    @vaccinations = filter_by_company(Vaccination.includes(:animal, :user)).recent
  end

  def show
  end

  def new
    @vaccination = Vaccination.new
    @animals = filter_by_company(Animal.all).order(:name)
  end

  def create
    @vaccination = Vaccination.new(vaccination_params)
    @vaccination.user = current_user
    @vaccination.company_id = @current_company_id

    if @vaccination.save
      redirect_to @vaccination, notice: 'Vacinação registrada com sucesso!'
    else
      @animals = filter_by_company(Animal.all).order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @animals = filter_by_company(Animal.all).order(:name)
  end

  def update
    if @vaccination.update(vaccination_params)
      redirect_to @vaccination, notice: 'Vacinação atualizada com sucesso!'
    else
      @animals = filter_by_company(Animal.all).order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccination.destroy
    redirect_to vaccinations_url, notice: 'Vacinação removida com sucesso!'
  end

  private

  def set_vaccination
    @vaccination = Vaccination.find(params[:id])
  end

  def vaccination_params
    params.require(:vaccination).permit(:animal_id, :vaccine_name, :vaccine_brand, :application_date, :next_dose_date, :veterinarian_name, :batch_number, :observations)
  end

  def ensure_same_company!
    super(@vaccination)
  end
end