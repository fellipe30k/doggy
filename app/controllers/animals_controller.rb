# app/controllers/animals_controller.rb
class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy, :qr_code]
  before_action :ensure_same_company!, only: [:show, :edit, :update, :destroy, :qr_code]

  def index
    @animals = filter_by_company(Animal.includes(:user, :company, :vaccinations))
  end

  def show
    @vaccinations = @animal.vaccinations.recent.limit(10)
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user = current_user
    @animal.company_id = @current_company_id
    
    # Encontrar ou criar owner se dados foram fornecidos
    if animal_params[:owner_name].present?
      @owner = Owner.find_or_initialize_by(
        name: animal_params[:owner_name],
        phone: animal_params[:owner_phone],
        email: animal_params[:owner_email],
        company_id: @current_company_id
      )
      @animal.owner = @owner if @owner.save
    end

    if @animal.save
      redirect_to @animal, notice: 'Animal cadastrado com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @animal.update(animal_params)
      redirect_to @animal, notice: 'Animal atualizado com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @animal.destroy
    redirect_to animals_url, notice: 'Animal removido com sucesso!'
  end

  def qr_code
    respond_to do |format|
      format.png do
        png = @animal.generate_qr_code
        send_data png.to_s, type: 'image/png', disposition: 'inline', filename: "qr_code_#{@animal.name.parameterize}.png"
      end
    end
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :species, :breed, :birth_date, :weight, :color, :microchip, :owner_name, :owner_phone, :owner_email, :photo)
  end

  def ensure_same_company!
    super(@animal)
  end
end
