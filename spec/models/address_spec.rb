require 'rails_helper'

RSpec.describe Address, type: :model do

  it 'is valid with valid attributes' do
    address = FactoryBot.build(:address)
    expect(address).to be_valid, address.errors.full_messages
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:uf) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:cep) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:neighborhood) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:contact) }
    it { is_expected.to have_one(:map).dependent(:destroy) }
  end
end
