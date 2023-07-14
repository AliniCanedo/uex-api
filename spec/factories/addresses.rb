FactoryBot.define do

  factory :address do

    uf { 'UF' }
    city { 'Cidade' }
    street { 'Rua' }
    cep { 'CEP' }
    complement { 'Complemento' }
    number { '123' }
    association :contact

  end

end
