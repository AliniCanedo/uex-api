class Address < ApplicationRecord
  belongs_to :contact
  has_one :map, dependent: :destroy

  validates :uf, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :cep, presence: true
end
