module PagSeguro
  class Payment < Request
    include ActiveModel::Validations

    validates_presence_of :currency, :payment_method, :items, :sender, :shipping
    validates_presence_of :bank, if: :paid_with_eft?
    validates_presence_of :credit_card, if: :paid_with_card?
    validates_inclusion_of :payment_method, in: %w(creditCard boleto eft)

    # Determines for which url PagSeguro will send the order related
    # notifications codes.
    # Optional. Any change happens in the transaction status, a new notification
    # request will be send to this url. You can use that for update the related
    # order.
    attr_accessor :notification_url

    # Set the payment currency.
    # Defaults to BRL.
    attr_accessor :currency

    # Set the payment method.
    # Payment method should be creditCard, boleto or eft.
    attr_accessor :payment_method

    # Set the payment mode
    attr_accessor :payment_mode

    # Set the reference code.
    # Optional. You can use the reference code to store an identifier so you can
    # associate the PagSeguro transaction to a transaction in your system.
    # Tipically this is the order id.
    attr_accessor :reference

    # Get the payment sender.
    attr_accessor :sender


    # Get the payment sender.
    attr_accessor :credit_card

    attr_accessor :receiver_email

    # Set the bank name.
    # Optional. Bank name should be used for eft payment method
    # to specify which the buyer should be redirect.
    attr_accessor :bank

    attr_accessor :shipping

    attr_accessor :extra_amount

    # Set the max installment with no interest.
    # Optional.
    attr_accessor :max_installment_no_interest

    # Products/items in this payment request.
    def items
      @items ||= Items.new
    end

    # Normalize the items list.
    def items=(_items)
      _items.each {|item| items << item }
    end

    # Calls the PagSeguro web service and register this request for payment.
    def transaction(account = nil)
      params = Serializer.new(self).to_params
      PagSeguro::Transaction.new post('/transactions', API_V2 ,account, params).parsed_response
    end

    def initialize(options = {})
      @currency = "BRL"
      @payment_mode = 'default'
      @notification_url = options[:notification_url]
      @payment_method = options[:payment_method]
      @reference = options[:reference] if options[:reference]
      @extra_amount = options[:extra_amount] if options[:extra_amount]
      @receiver_email = options[:receiver_email] if options[:receiver_email]
    end

    private
    def paid_with_card?
      payment_method == "creditCard"
    end

    def paid_with_eft?
      payment_method == "eft"
    end
  end
end
