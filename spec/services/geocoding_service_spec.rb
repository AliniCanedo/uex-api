require 'rails_helper'

RSpec.describe Addresses::GeocodingService, type: :service do
  describe '#call' do
    let(:options) { { address: '123 Main St, City' } }
    let(:api_geo_coding) { instance_double('::Addresses::ApiGeoCoding') }
    let(:geocoding_result) { instance_double('GeocodingResult') }

    before do
      allow(::Addresses::ApiGeoCoding).to receive(:new).with(options).and_return(api_geo_coding)
      allow(api_geo_coding).to receive(:geo_coding).and_return(geocoding_result)
    end

    subject { described_class.new(options) }

    it 'creates a new instance of ::Addresses::ApiGeoCoding with the provided options' do
      expect(::Addresses::ApiGeoCoding).to receive(:new).with(options)
      subject.call
    end

    it 'calls the geo_coding method on the api_geo_coding object' do
      expect(api_geo_coding).to receive(:geo_coding)
      subject.call
    end

    it 'returns the geocoding result' do
      expect(subject.call).to eq(geocoding_result)
    end
  end
end
