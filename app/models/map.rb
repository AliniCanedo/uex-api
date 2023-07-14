class Map < ApplicationRecord
  belongs_to :address

  validates :latitude, presence: true
  validates :longitude, presence: true
end
