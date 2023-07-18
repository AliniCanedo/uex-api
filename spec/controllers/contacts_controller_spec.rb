require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe 'GET #index' do
    it 'assigns @contacts with all contacts' do
      user = FactoryBot.create(:user)
      sign_in user
      request.headers['Authorization'] = "#{user.authentication_token}"
      contact1 = FactoryBot.create(:contact)
      contact2 = FactoryBot.create(:contact)      
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = FactoryBot.create(:user)
      sign_in user
      request.headers['Authorization'] = "#{user.authentication_token}"
      contact = FactoryBot.create(:contact)
      get :show, params: { id: contact.id }
      expect(response).to be_successful
    end

    it 'assigns @contact with the specified contact' do
      user = FactoryBot.create(:user)
      sign_in user
      request.headers['Authorization'] = "#{user.authentication_token}"
      contact = FactoryBot.create(:contact)
      get :show, params: { id: contact.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new contact' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
        expect do
          post :create, params: { contact: FactoryBot.attributes_for(:contact, name: 'John Doe', user_id: user.id) }
        end.to change(Contact, :count).by(1)
      end

      it 'returns a success response with the created contact' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
      
        post :create, params: { contact: FactoryBot.attributes_for(:contact, name: 'John Doe') }
      
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new contact' do        
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
        expect do
          post :create,
               params: { contact: FactoryBot.attributes_for(:contact, name: nil, cpf: nil, phone: nil, user_id: nil) }
        end.not_to change(Contact, :count)

      end

      it 'returns an error response with the contact errors' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
        post :create,
             params: { contact: FactoryBot.attributes_for(:contact, name: nil, cpf: nil, phone: nil, user_id: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key('errors')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the specified contact' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
        contact = FactoryBot.create(:contact)
        patch :update, params: { id: contact.id, contact: { name: 'Updated Name' } }
        contact.reload
        expect(contact.name) == 'Updated Name'
      end

      it 'returns a success response' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
        contact = FactoryBot.create(:contact)

        patch :update, params: { id: contact.id, contact: { name: 'Updated Name' } }

        expect(response).to have_http_status(:success)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq(I18n.t('json.contact_updated_success'))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the specified contact' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"
        contact = FactoryBot.create(:contact)

        patch :update, params: { id: contact.id, contact: { name: nil } }

        contact.reload
        expect(contact.name).not_to be_nil
      end

      it 'returns an error response' do
        user = FactoryBot.create(:user)
        sign_in user
        request.headers['Authorization'] = "#{user.authentication_token}"

        contact = FactoryBot.create(:contact)
        patch :update, params: { id: contact.id, contact: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq(I18n.t('json.contact_update_error'))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the specified contact' do
      user = FactoryBot.create(:user)
      sign_in user
      request.headers['Authorization'] = "#{user.authentication_token}"
      contact = FactoryBot.create(:contact)

      expect do
        delete :destroy, params: { id: contact.id }
      end.to change(Contact, :count).by(-1)
    end

   it 'returns a success response' do
      user = FactoryBot.create(:user)
      sign_in user
      request.headers['Authorization'] = "#{user.authentication_token}"
      contact = FactoryBot.create(:contact)

      delete :destroy, params: { id: contact.id }

      expect(response).to have_http_status(:success)

      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq(I18n.t('json.contact_destroyed_success'))
    end
  end
end
