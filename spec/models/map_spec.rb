require 'rails_helper'

RSpec.describe Map, type: :model do
  it "is valid with valid attributes" do
    map = FactoryBot.create(:map)
    expect(map).to be_valid  
  end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:address) }
  end
end
