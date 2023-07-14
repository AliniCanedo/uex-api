require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'DELETE #destroy' do
    it 'signs out the user' do
      user = FactoryBot.create(:user)
      sign_in user

      @request.env['devise.mapping'] = Devise.mappings[:user]

      delete :destroy

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({ 'message' => I18n.t('json.logout_success') })
    end
  end
end
