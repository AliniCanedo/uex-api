class Addresses::QueryAddressService < ApplicationService
  def initialize(options)
    @options = options
  end

  def call
    ::Addresses::ApiViaCep.new(@options).address
  end
end
