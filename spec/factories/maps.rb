FactoryBot.define do

  factory :map do

    latitude { 0.0 }
    longitude { 0.0 }
    association :address

  end

end
