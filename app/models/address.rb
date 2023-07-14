class Address < ApplicationRecord
  belongs_to :contact
  has_one :map, dependent: :destroy

  accepts_nested_attributes_for :map

  validates :uf, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :cep, presence: true
  validates :number, presence: true
end
