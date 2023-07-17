class Contact < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  has_one :map, through: :address

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :phone, presence: true
end
