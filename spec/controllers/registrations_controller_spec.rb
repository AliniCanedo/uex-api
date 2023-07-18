require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            name: 'John Doe',
            email: 'john.doe@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'creates a new user' do
        @request.env['devise.mapping'] = Devise.mappings[:user]

        post :create, params: valid_params

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ 'success' => true, 'message' => I18n.t('json.user_created_success') })
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            name: 'John Doe',
            email: 'invalid_email',
            password: 'password',
            password_confirmation: 'different_password'
          }
        }
      end

      it 'returns errors' do
        @request.env['devise.mapping'] = Devise.mappings[:user]

        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 'success' => false, 'errors' => { 'email' => ['E-mail Não é válido'], 'password_confirmation' => ['As senhas não coincidem'] } })
      end
    end
  end
end
