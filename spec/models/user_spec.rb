require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with valid attributes' do

    user = FactoryBot.create(:user)
    expect(user).to be_valid

  end

  context 'Validates' do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

  end

  context 'Associations' do

    it { is_expected.to have_many(:contacts) }

  end

end
