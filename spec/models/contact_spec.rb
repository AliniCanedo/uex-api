require 'rails_helper'

RSpec.describe Contact, type: :model do

  it 'is valid with valid attributes' do

    contact = FactoryBot.create(:contact)
    expect(contact).to be_valid

  end

  context 'Validates' do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:phone) }

  end

  context 'Associations' do

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:address) }
    it { is_expected.to have_one(:map).through(:address) }

  end

end
