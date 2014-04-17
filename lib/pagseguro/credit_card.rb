module PagSeguro
  class CreditCard
    include ActiveModel::Validations

    validates_presence_of :token, :installment, :holder, :billing_address

    # Set the token that represents the credit card.
    attr_accessor :token

    # Set the CPF document.
    attr_accessor :installment

    # Get the sender phone.
    attr_accessor :holder

    # Get the sender phone.
    attr_accessor :billing_address

    def initialize(token)
      @token = token
    end
  end
end
