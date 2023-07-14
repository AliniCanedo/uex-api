class Addresses::GeocodingService < ApplicationService
  def initialize(options)
    @options = options
  end

  def call
    ::Addresses::ApiGeoCoding.new(@options).geo_coding
  end
end
