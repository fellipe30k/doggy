# app/controllers/animals_controller.rb
class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy, :qr_code, :vaccination_card]
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

  def vaccination_card
    @vaccinations = @animal.vaccinations.recent.limit(10)
    @qr_code_data_url = generate_qr_code_data_url
    @format = params[:format] || 'portrait' # portrait (300x600) ou landscape (600x300)

    request.format = :html

    respond_to do |format|
      format.html { render layout: false }
    end
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

  def generate_qr_code_data_url
    require 'rqrcode'
    begin
      qr_url = @animal.qr_code_data
      qrcode = RQRCode::QRCode.new(qr_url, size: 4, level: :m)
      png = qrcode.as_png(
        resize_gte_to: false,
        resize_exactly_to: false,
        fill: 'white',
        color: 'black',
        size: 200,
        border_modules: 2
      )
      "data:image/png;base64,#{Base64.strict_encode64(png.to_s)}"
    rescue => e
      Rails.logger.error "Erro ao gerar QR Code: #{e.message}"
      # Fallback: gerar QR code simples
      "data:image/svg+xml;base64,#{Base64.strict_encode64(generate_fallback_qr_svg)}"
    end
  end

  def generate_fallback_qr_svg
    # SVG simples como fallback caso o PNG falhe
    <<~SVG
      <svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
        <rect width="200" height="200" fill="white" stroke="#333" stroke-width="2"/>
        <text x="100" y="90" text-anchor="middle" font-family="Arial" font-size="14" fill="#333">QR CODE</text>
        <text x="100" y="110" text-anchor="middle" font-family="Arial" font-size="12" fill="#666">#{@animal.name}</text>
        <text x="100" y="130" text-anchor="middle" font-family="Arial" font-size="10" fill="#999">Escaneie para ver</text>
        <text x="100" y="145" text-anchor="middle" font-family="Arial" font-size="10" fill="#999">histórico completo</text>
      </svg>
    SVG
  end

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
