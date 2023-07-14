class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = Contact.all
    render json: @contacts
  end

  def show
    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params)

    return render json: { message: I18n.t('json.contact_created_success') }, status: :created if @contact.save

    render json: { error: @contact.errors }, status: :unprocessable_entity
  end

  def update
    @contact = Contact.find(params[:id])

    return render json: { message: I18n.t('json.contact_updated_success') } if @contact.update(contact_params)

    render json: { error: I18n.t('json.contact_update_error') }, status: :unprocessable_entity
  end

  def destroy
    @contact = Contact.find(params[:id])

    return render json: { message: I18n.t('json.contact_destroyed_success') } if @contact.destroy

    render json: { error: I18n.t('json.contact_destroy_error') }, status: :unprocessable_entity
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :cpf, :phone, :user_id, address_attributes: [:uf, :city, :street, :cep, :number, map_attributes: [:latitude, :longitude]])
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
