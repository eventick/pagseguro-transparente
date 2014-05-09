module PagSeguro
  class Transaction
    attr_reader :response, :errors

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

    def fee_amount
      transaction['feeAmount']
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
      [response['errors']].compact
    end

    private

    def transaction
      response['transaction']
    end
  end
end
