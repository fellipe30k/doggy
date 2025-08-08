# app/controllers/staff/users_controller.rb
class Staff::UsersController < Staff::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @company = @current_company_id ? Company.find(@current_company_id) : nil
    @users = @company ? @company.users.includes(:company) : User.includes(:company).all
    @users = @users.order(:first_name, :last_name)
  end

  def show
    @animals_count = @user.animals.count
    @vaccinations_count = @user.vaccinations.count
  end

  def new
    @user = User.new
    @user.company_id = @current_company_id if @current_company_id
  end

  def create
    @user = User.new(user_params)
    @user.active = true

    if @user.save
      redirect_to staff_user_path(@user), notice: 'Usuário criado com sucesso!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params.except(:password, :password_confirmation))
      redirect_to staff_user_path(@user), notice: 'Usuário atualizado com sucesso!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.update(active: false)
    redirect_to staff_users_path, notice: 'Usuário desativado com sucesso!'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :role, :company_id, :password, :password_confirmation, :active)
  end
end
