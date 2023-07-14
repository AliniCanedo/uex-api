class AddressesController < ApplicationController
  def search_address
    result = ::Addresses::QueryAddressService.new(payload: params[:cep]).call

    return render json: result[:body], status: :ok if result[:status] == 200

    render json: { error: 'Invalid request' }, status: :unprocessable_entity
  end
end
