module Addresses
	class ApiGeoCoding
		MAPS_API = ENV.fetch('MAPS_API', '')
		MAPS_API_KEY = ENV.fetch('MAPS_API_KEY', '')
		
    def initialize(options)
      @options = options
    end

		def geo_coding
			response = Faraday.get("#{MAPS_API}address=#{@options}&key=#{MAPS_API_KEY}", nil, headers)
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
