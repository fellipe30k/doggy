class Owner < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :company
  has_many :animals, dependent: :nullify
end
