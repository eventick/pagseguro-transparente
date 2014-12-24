require 'httparty'

module PagSeguro
  class Request
    include HTTParty
    debug_output $stderr

    base_uri environment_uri

    def get(path, account = "default")
      options = { query: add_credencials(account) }
      self.class.get(path, options)
    end

    def post(path, account = "default", params = {})
      options = { body: add_credencials(account) }
      options[:body].merge!(params)
      options[:timeout] = PagSeguro.timeout unless PagSeguro.timeout.blank?
      self.class.post(path, options)
    end

    private
      def add_credencials(account)
        if account == "alternative"
           { email: PagSeguro.alt_email, token: PagSeguro.alt_token }
        else
           { email: PagSeguro.email, token: PagSeguro.token }
        end
      end

      def environment_uri
        return "https://ws.pagseguro.uol.com.br/v2/" if PagSeguro.environment == :production
        "https://ws.sandbox.pagseguro.uol.com.br/v2/"
      end
  end
end
