# app/controllers/animals_controller.rb
class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]
  before_action :ensure_same_company!, only: [:show, :edit, :update, :destroy]

  def index
    @animals = filter_by_company(Animal.includes(:user, :company)).page(params[:page])
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
    @owner = Owner.find_or_initialize_by(name: params[:animal][:owner_name],
                                         phone: params[:animal][:owner_phone],
                                         email: params[:animal][:owner_email],
                                         company_id: @current_company_id)
    @animal.owner = @owner if @owner.save

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
    @animal = Animal.find(params[:id])
    ensure_same_company!(@animal)
    
    respond_to do |format|
      format.png do
        png = @animal.generate_qr_code
        send_data png.to_s, type: 'image/png', disposition: 'inline'
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