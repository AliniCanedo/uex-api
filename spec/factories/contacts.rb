FactoryBot.define do

  factory :contact do

    name { 'Jane Smith' }
    cpf { '12345678901' }
    phone { '987654321' }
    association :user

  end

end
