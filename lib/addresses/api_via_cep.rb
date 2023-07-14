module Addresses
  class ApiViaCep
    VIACEP_API = ENV.fetch('VIACEP_API', '')

    def initialize(options)
      @options = options
    end

    def address
      response = Faraday.get("#{VIACEP_API}/#{@options[:payload]}/json", nil, headers)

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
