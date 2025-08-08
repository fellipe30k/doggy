# app/models/animal.rb
class Animal < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :owner, optional: true
  has_many :vaccinations, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :species, presence: true
  validates :birth_date, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }

  scope :by_company, ->(company_id) { where(company_id: company_id) }

  def age_in_years
    return 0 unless birth_date
    ((Date.current - birth_date) / 365.25).floor
  end

  def qr_code_data
    Rails.application.routes.url_helpers.animal_vaccinations_url(self, host: Rails.application.config.action_mailer.default_url_options[:host])
  end

  def generate_qr_code
    require 'rqrcode'
    qrcode = RQRCode::QRCode.new(qr_code_data)
    qrcode.as_png(size: 300)
  end
end