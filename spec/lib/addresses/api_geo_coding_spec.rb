require 'rails_helper'
require 'json'

RSpec.describe Addresses::ApiGeoCoding, type: :lib do
  let(:options) { { address: '123 Main St, City' } }
  let(:response) { instance_double(Faraday::Response) }
  let(:body) { { 'results' => [{ 'formatted_address' => '123 Main St, City' }] } }

  before do
    allow(Faraday).to receive(:get).and_return(response)
    allow(response).to receive(:status).and_return(200)
    allow(response).to receive(:body).and_return(JSON.generate(body))
  end

  subject { described_class.new(options) }

  describe '#geo_coding' do
    it 'returns a hash with the response status and body' do
      expect(subject.geo_coding).to eq({ status: 200, body: body })
    end
  end
end
