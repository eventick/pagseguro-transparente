require "active_model"
require "pagseguro/version"
require "pagseguro/request"
require "pagseguro/session"
require "pagseguro/session/response"
require "pagseguro/item"
require "pagseguro/items"
require "pagseguro/payment"
require "pagseguro/payment/serializer"
require "pagseguro/transaction"
require "pagseguro/transaction/address"
require "pagseguro/transaction/item"
require "pagseguro/transaction/items"
require "pagseguro/transaction/payment_method"
require "pagseguro/transaction/phone"
require "pagseguro/transaction/sender"
require "pagseguro/transaction/shipping"
require "pagseguro/notification"
require "pagseguro/query"
require "pagseguro/sender"
require "pagseguro/phone"
require "pagseguro/document"
require "pagseguro/bank"
require "pagseguro/credit_card"
require "pagseguro/holder"
require "pagseguro/address"
require "pagseguro/shipping"
require "pagseguro/installment"
require "pagseguro/refund"

I18n.enforce_available_locales = false
I18n.load_path += Dir[File.expand_path('../../config/locales/*.yml',  __FILE__)]

module PagSeguro
  class << self
    # Primary e-mail associated with the primary account.
    attr_accessor :email

    # The API token associated with primary account.
    attr_accessor :token

    # Sencondary e-mail associated with secondary account.
    attr_accessor :alt_email

    # The API token associated with secondary account.
    attr_accessor :alt_token

    # The PagSeguro environment.
    # Only +production+ for now.
    attr_accessor :environment

    # Timeout value in seconds for requests.
    attr_accessor :timeout

    def api_url
      uris.fetch(environment)
    end

    private
    def uris
      @uris ||= {
        production: 'https://ws.pagseguro.uol.com.br/v2',
        sandbox: 'https://ws.sandbox.pagseguro.uol.com.br/v2'
      }
    end
  end

  self.environment = :production

  # Set the global configuration.
  #
  #   PagSeguro.configure do |config|
  #     config.email = "john@example.com"
  #     config.token = "abc"
  #     config.environment = :sandbox
  #   end
  #
  def self.configure(&block)
    yield self
  end
end
