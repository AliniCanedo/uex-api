FactoryBot.define do
  factory :address do
    uf { Faker::Address.state_abbr }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    cep { Faker::Address.zip_code }
    complement { Faker::Address.secondary_address }
    number { Faker::Address.building_number }
    association :contact
  end
end
