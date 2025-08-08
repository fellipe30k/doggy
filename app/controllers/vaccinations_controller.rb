class VaccinationsController < ApplicationController
  before_action :set_vaccination, only: %i[ show edit update destroy ]

  # GET /vaccinations or /vaccinations.json
  def index
    @vaccinations = Vaccination.all
  end

  # GET /vaccinations/1 or /vaccinations/1.json
  def show
  end

  # GET /vaccinations/new
  def new
    @vaccination = Vaccination.new
  end

  # GET /vaccinations/1/edit
  def edit
  end

  # POST /vaccinations or /vaccinations.json
  def create
    @vaccination = Vaccination.new(vaccination_params)

    respond_to do |format|
      if @vaccination.save
        format.html { redirect_to @vaccination, notice: "Vaccination was successfully created." }
        format.json { render :show, status: :created, location: @vaccination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vaccination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vaccinations/1 or /vaccinations/1.json
  def update
    respond_to do |format|
      if @vaccination.update(vaccination_params)
        format.html { redirect_to @vaccination, notice: "Vaccination was successfully updated." }
        format.json { render :show, status: :ok, location: @vaccination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vaccination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vaccinations/1 or /vaccinations/1.json
  def destroy
    @vaccination.destroy!

    respond_to do |format|
      format.html { redirect_to vaccinations_path, status: :see_other, notice: "Vaccination was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vaccination
      @vaccination = Vaccination.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def vaccination_params
      params.expect(vaccination: [ :animal_id, :vaccine_name, :vaccine_brand, :application_date, :next_dose_date, :veterinarian_name, :batch_number, :observations, :user_id, :company_id ])
    end
end
