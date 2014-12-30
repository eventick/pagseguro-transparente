require 'httparty'

module PagSeguro
  class Request
    include HTTParty
    debug_output $stderr

    def get(path, account = "default")
      self.class.base_uri sandbox_uri!
      options = { query: add_credencials(account) }
      self.class.get(path, options)
    end

    def post(path, account = "default", params = {})
      self.class.base_uri sandbox_uri!
      options = { body: add_credencials(account) }
      options[:body].merge!(params)
      options[:timeout] = PagSeguro.timeout unless PagSeguro.timeout.blank?
      self.class.post(path, options)
    end

    def sandbox_uri!
      if PagSeguro.sandbox?
        return "https://ws.sandbox.pagseguro.uol.com.br/v2/"
      end

      "https://ws.pagseguro.uol.com.br/v2/"
    end

    private
      def add_credencials(account)
        if account == "alternative"
           { email: PagSeguro.alt_email, token: PagSeguro.alt_token }
        else
           { email: PagSeguro.email, token: PagSeguro.token }
        end
      end

  end
end
