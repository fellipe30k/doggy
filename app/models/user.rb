# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company, optional: true
  has_many :animals, dependent: :destroy
  has_many :vaccinations, dependent: :destroy

  enum :role, { staff: 0, admin: 1, user: 2, owner: 3 }

  validates :role, presence: true
  validates :first_name, :last_name, presence: true
  validates :phone, presence: true, format: { with: /\A[\d\s\-\(\)\+]+\z/ }
  validates :company_id, presence: true, unless: :staff?

  scope :active, -> { where(active: true) }
  scope :by_company, ->(company_id) { where(company_id: company_id) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_manage_company?
    staff? || admin?
  end

  def can_switch_companies?
    staff?
  end
end
