require "active_model"
require "pagseguro/version"
require "pagseguro/request"
require "pagseguro/session"
require "pagseguro/session/response"
require "pagseguro/item"
require "pagseguro/items"
require "pagseguro/transaction"
require "pagseguro/transaction/serializer"
require "pagseguro/notification"
require "pagseguro/notification/address"
require "pagseguro/notification/item"
require "pagseguro/notification/items"
require "pagseguro/notification/payment_method"
require "pagseguro/notification/phone"
require "pagseguro/notification/sender"
require "pagseguro/notification/shipping"
require "pagseguro/sender"
require "pagseguro/phone"
require "pagseguro/document"
require "pagseguro/bank"
require "pagseguro/credit_card"
require "pagseguro/holder"
require "pagseguro/address"
require "pagseguro/shipping"
require "pagseguro/installment"
require "pagseguro/exceptions"

I18n.enforce_available_locales = false

module PagSeguro
  class << self
    # Primary e-mail associated with this account.
    attr_accessor :email

    # The API token associated with this account.
    attr_accessor :token

    # The PagSeguro environment.
    # Only +production+ for now.
    attr_accessor :environment
  end

  self.environment = :production

  # Set the global configuration.
  #
  #   PagSeguro.configure do |config|
  #     config.email = "john@example.com"
  #     config.token = "abc"
  #   end
  #
  def self.configure(&block)
    yield self
  end
end
