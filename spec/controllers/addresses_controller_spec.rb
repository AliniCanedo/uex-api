require 'rails_helper'

RSpec.describe AddressesController, type: :controller do

  describe 'GET #search_address' do
    let(:valid_params) { { cep: '12345678' } }
    let(:invalid_params) { { cep: 'invalid' } }

    context 'when the address is found' do
      let(:address_data) do
        {
          'uf' => 'SP',
          'localidade' => 'São Paulo',
          'logradouro' => 'Rua Teste',
          'latitude' => 1.234567,
          'longitude' => -1.234567
        }
      end

      before do
        allow_any_instance_of(::Addresses::QueryAddressService).to receive(:call).and_return(status: 200, body: address_data)
        allow_any_instance_of(::Addresses::GeocodingService).to receive(:call).and_return(status: 200, body: { 'results' => [{ 'geometry' => { 'location' => { 'lat' => 1.234567, 'lng' => -1.234567 } } }] })
      end

      it 'returns the address data with coordinates' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"

        get :search_address, params: valid_params

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(address_data)
      end
    end

    context 'when the address is not found' do

      before do

        allow_any_instance_of(::Addresses::QueryAddressService).to receive(:call).and_return(status: 404)

      end

      it 'returns an error message' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"

        get :search_address, params: valid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 'error' => I18n.t('requests.address.invalid_request') })

      end

    end

  end

end
