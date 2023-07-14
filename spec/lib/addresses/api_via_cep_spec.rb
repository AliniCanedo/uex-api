require 'rails_helper'
require 'json'

RSpec.describe Addresses::ApiViaCep, type: :lib do
  let(:options) { { payload: '12345678' } }
  let(:response) { instance_double(Faraday::Response) }
  let(:body) { { 'cep' => '12345678', 'logradouro' => 'Rua Principal', 'cidade' => 'Cidade', 'estado' => 'SP' } }

  before do
    allow(Faraday).to receive(:get).and_return(response)
    allow(response).to receive(:status).and_return(200)
    allow(response).to receive(:body).and_return(JSON.generate(body))
  end

  subject { described_class.new(options) }

  describe '#address' do
    it 'sends a GET request to the ViaCEP API with the provided payload' do
      expected_url = "https://viacep.com.br/ws/#{options[:payload]}/json"
      expect(Faraday).to receive(:get).with(expected_url, nil, { 'Content-Type' => 'application/json' })
      subject.address
    end

    it 'returns a hash with the response status and body' do
      expect(subject.address).to eq({ status: 200, body: body })
    end
  end
end
