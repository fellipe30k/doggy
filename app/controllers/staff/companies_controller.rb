# app/controllers/staff/companies_controller.rb
class Staff::CompaniesController < Staff::BaseController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all.order(:name)
  end

  def show
    @users_count = @company.users.count
    @animals_count = @company.animals.count
    @vaccinations_count = @company.vaccinations.count
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      redirect_to staff_company_path(@company), notice: 'Clínica criada com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to staff_company_path(@company), notice: 'Clínica atualizada com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
    redirect_to staff_companies_path, notice: 'Clínica removida com sucesso!'
  end

  def switch
    company = Company.find(params[:id]) if params[:id] != '0'
    session[:staff_company_id] = company&.id
    redirect_to root_path, notice: company ? "Alternado para #{company.name}" : "Voltando para visão geral"
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :cnpj, :address, :phone, :email, :active)
  end
end