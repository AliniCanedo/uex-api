class AddressesController < ApplicationController
  def search_address
    result = ::Addresses::QueryAddressService.new(payload: params[:cep].gsub('-', '')).call
    if result[:status] == 200
      address_data = result[:body]
      process_address_data(address_data)
    else
      render json: { error: I18n.t('requests.address.invalid_request') }, status: :unprocessable_entity
    end
  end

  def address
    result = ::Addresses::AddressService.new(payload: params[:address]).call

    render json: result
  end

  private

  def process_address_data(address_data)
    coordinates = geocode_address(full_address(address_data))
    if coordinates.present?
      assign_coordinates(address_data, coordinates)
      render json: address_data, status: :ok
    else
      render json: { error: I18n.t('requests.address.geocode_failed') }, status: :unprocessable_entity
    end
  end

  def geocode_address(address)
    ::Addresses::GeocodingService.new(address).call[:body]['results'][0]['geometry']['location']
  end

  def assign_coordinates(address_data, coordinates)
    address_data['latitude'] = coordinates['lat'] if coordinates['lat'].present?
    address_data['longitude'] = coordinates['lng'] if coordinates['lng'].present?
  end

  def full_address(address_data)
    "#{address_data['uf']}, #{address_data['localidade']}, #{address_data['logradouro']}"
  end
end
