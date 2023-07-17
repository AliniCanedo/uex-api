class Addresses::AddressService < ApplicationService
  def initialize(options)
    @options = options
  end

  def call
    ::Addresses::ApiAddress.new(@options).address
  end
end
