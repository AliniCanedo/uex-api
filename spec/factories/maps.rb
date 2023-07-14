FactoryBot.define do
  factory :map do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    association :address
  end
end
