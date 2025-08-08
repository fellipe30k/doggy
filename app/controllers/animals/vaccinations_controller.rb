# app/controllers/animals/vaccinations_controller.rb
class Animals::VaccinationsController < ApplicationController
  before_action :set_animal
  before_action :set_vaccination, only: [:show, :edit, :update, :destroy]
  before_action :ensure_same_company!

  def index
    @vaccinations = @animal.vaccinations.recent
  end

  def show
  end

  def new
    @vaccination = @animal.vaccinations.build
    @vaccination.application_date = Date.current
  end

  def create
    @vaccination = @animal.vaccinations.build(vaccination_params)
    @vaccination.user = current_user
    @vaccination.company_id = @current_company_id

    if @vaccination.save
      redirect_to animal_path(@animal), notice: 'Vacinação registrada com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vaccination.update(vaccination_params)
      redirect_to animal_path(@animal), notice: 'Vacinação atualizada com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccination.destroy
    redirect_to animal_path(@animal), notice: 'Vacinação removida com sucesso!'
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def set_vaccination
    @vaccination = @animal.vaccinations.find(params[:id])
  end

  def vaccination_params
    params.require(:vaccination).permit(:vaccine_name, :vaccine_brand, :application_date, :next_dose_date, :veterinarian_name, :batch_number, :observations)
  end

  def ensure_same_company!
    super(@animal)
  end
end
