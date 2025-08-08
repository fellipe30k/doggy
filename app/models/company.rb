# app/models/company.rb
class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :animals, dependent: :destroy
  has_many :vaccinations, dependent: :destroy
  has_many :owners, dependent: :destroy

  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true

  scope :active, -> { where(active: true) }
end