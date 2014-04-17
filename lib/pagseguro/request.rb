require 'httparty'

module PagSeguro
  class Request
    include HTTParty
    debug_output $stderr

    base_uri "https://ws.pagseguro.uol.com.br/v2/"

    def get(path, options = {})
      self.class.get(path, options)
    end

    def post(path, params = {})
      options = { body: { email: PagSeguro.email, token: PagSeguro.token} }
      options[:body].merge!(params)
      response = self.class.post(path, options)
      response.parsed_response
    end
  end
end
