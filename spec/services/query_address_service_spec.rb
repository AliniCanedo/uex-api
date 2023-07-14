require 'rails_helper'

RSpec.describe Addresses::QueryAddressService, type: :service do
  describe '#call' do
    let(:options) { { cep: '12345678' } }
    let(:api_via_cep) { instance_double('::Addresses::ApiViaCep') }
    let(:address) { instance_double('Address') }

    before do
      allow(::Addresses::ApiViaCep).to receive(:new).with(options).and_return(api_via_cep)
      allow(api_via_cep).to receive(:address).and_return(address)
    end

    subject { described_class.new(options) }

    it 'creates a new instance of ::Addresses::ApiViaCep with the provided options' do
      expect(::Addresses::ApiViaCep).to receive(:new).with(options)
      subject.call
    end

    it 'calls the address method on the api_via_cep object' do
      expect(api_via_cep).to receive(:address)
      subject.call
    end

    it 'returns the address object' do
      expect(subject.call).to eq(address)
    end
  end
end
