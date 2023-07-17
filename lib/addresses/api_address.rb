require 'uri'

module Addresses
  class ApiAddress
    MAPS_API_KEY = ENV.fetch('MAPS_API_KEY', '')
    MAPS_API_TEXT = ENV.fetch('MAPS_API_TEXT', '')

    def initialize(options)
      @options = options[:payload]
    end

    def address
      response = Faraday.get("#{MAPS_API_TEXT}query=#{@options[:address].upcase}&key=#{MAPS_API_KEY}", nil, headers)

      {
        status: response.status,
        body: JSON.parse(response.body)
      }
    end

    private

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end
