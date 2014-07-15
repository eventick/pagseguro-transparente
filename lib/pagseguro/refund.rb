module PagSeguro
  class Refund < Request
    attr_accessor :response

    def initialize(transaction_code)
      @transaction_code = transaction_code
      @response = {}
    end

    def request
      @response = post("/transactions/refunds", transactionCode: @transaction_code)

      @response['result'] == 'OK'
    end

    def errors
      @response['errors'] ||= {'error' => []}

      [@response['errors']['error']].flatten
    end
  end
end
