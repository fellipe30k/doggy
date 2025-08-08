# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @animals_count = filter_by_company(Animal.all).count
    @vaccinations_count = filter_by_company(Vaccination.where('application_date >= ?', Date.current.beginning_of_month)).count
    @recent_animals = filter_by_company(Animal.includes(:vaccinations)).limit(5)
    @recent_vaccinations = filter_by_company(Vaccination.includes(:animal)).recent.limit(10)
  end
end
