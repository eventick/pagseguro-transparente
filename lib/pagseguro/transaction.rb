module PagSeguro
  class Transaction
    extend Forwardable
    attr_reader :response

    def_delegators :creditor_fees, :installment_fee_amount,
     :intermediation_rate_amount, :intermediation_fee_amount

    PAYMENT_STATUS = { '1' => :awaiting_payment, '2' => :pending, '3' => :paid,
      '4' => :available, '5' => :in_dispute, '6' => :refunded, '7' => :canceled,
      '8' => :chargeback, '9' => :plea }

    def initialize(response)
      @response = response
    end

    def date
      transaction['date']
    end

    def last_event_date
      transaction['lastEventDate']
    end

    def code
      transaction['code']
    end

    def reference
      transaction['reference']
    end

    def type
      transaction['type']
    end

    def status
      transaction['status']
    end

    def status_name
      PAYMENT_STATUS[status]
    end

    def cancellation_source
      transaction['cancellationSource']
    end

    def payment_method
      PaymentMethod.new(transaction['paymentMethod'])
    end

    def payment_link
      transaction['paymentLink']
    end

    def gross_amount
      transaction['grossAmount']
    end

    def discount_amount
      transaction['discountAmount']
    end

    def escrow_end_date
      transaction['escrowEndDate']
    end

    def net_amount
      transaction['netAmount']
    end

    def extra_amount
      transaction['extraAmount']
    end

    def installment_count
      transaction['installmentCount']
    end

    def items
      Items.new(transaction['paymentMethod'], transaction['itemCount'])
    end

    def sender
      Sender.new(transaction['sender'])
    end

    def shipping
      Shipping.new(transaction['shipping'])
    end

    def valid?
      !transaction.blank?
    end

    def errors
      response['errors'] ||= {'error' => []}

      [response['errors']['error']].flatten
    end

    def fee_amount
      transaction['feeAmount'] || creditor_fees.fee_amount
    end

    private
    def transaction
      @transaction ||= response['transaction']
    end

    def creditor_fees
      @creditor_fees ||= CreditorFees.new(transaction['creditorFees'])
    end
  end
end
