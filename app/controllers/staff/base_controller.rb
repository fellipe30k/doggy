# app/controllers/staff/base_controller.rb
class Staff::BaseController < ApplicationController
  before_action :ensure_staff!
  layout 'staff'

  private

  def ensure_staff!
    redirect_to root_path, alert: 'Acesso negado.' unless current_user&.staff?
  end
end
