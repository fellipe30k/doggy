# app/models/vaccination.rb
class Vaccination < ApplicationRecord
  belongs_to :animal
  belongs_to :user
  belongs_to :company

  validates :vaccine_name, presence: true
  validates :vaccine_brand, presence: true
  validates :application_date, presence: true
  validates :veterinarian_name, presence: true
  validates :batch_number, presence: true

  scope :by_company, ->(company_id) { where(company_id: company_id) }
  scope :recent, -> { order(application_date: :desc) }

  def overdue?
    next_dose_date && next_dose_date < Date.current
  end
end