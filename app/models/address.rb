class Address < ApplicationRecord
  belongs_to :contact

  has_one :map
end
