require 'httparty'

module PagSeguro
  class Request
    include HTTParty
    debug_output $stderr

    base_uri "https://ws.pagseguro.uol.com.br/v2/"

    def get(path)
      options = { query: {
          email: PagSeguro.email,
          token: PagSeguro.token
        }
      }
      self.class.get(path, options)
    end

    def post(path, params = {})
      options = add_credencials(params)

      self.class.post(path, options)
    end

    private
    def add_credencials(params)
      options = { body:
        {
          email: PagSeguro.email,
          token: PagSeguro.token
        }
      }
      options[:body].merge!(params)
      options
    end
  end
end
