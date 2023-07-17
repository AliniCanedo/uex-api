class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show update destroy]

  def index
    @contacts = Contact.where(user_id: @current_user.id).includes(:address, :map)
    render json: @contacts, include: %i[address map]
  end

  def show
    render json: @contact, include: { address: { include: :map } }
  end

  def create
    @contact = Contact.new(contact_params.merge(user_id: @current_user.id))

    if @contact.save
      render json: { message: I18n.t('json.contact_created_success') }, status: :created
    else
      render json: { errors: @contact.errors }, status: :unprocessable_entity
    end
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
    params.require(:contact).permit(:name, :cpf, :phone, :user_id,
                                    address_attributes: [:uf, :city, :street, :cep, :number, :complement, :neighborhood, { map_attributes: %i[latitude longitude] }])
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
