FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    phone { Faker::PhoneNumber.phone_number }
    association :user
  end
end
