module PagSeguro
  class Refund < Request
    attr_accessor :request

    def initialize(transaction_code)
      @transaction_code = transaction_code
      @request = {}
    end

    def request(account = nil)
      @request = post("/transactions/refunds", account, transactionCode: @transaction_code)
      @request.response.code == '200'
    end

    def errors
      case @request.response.code
      when '400'
        errors = @request.parsed_response
        [errors['errors']['error']].flatten
      when '200'
        []
      when '403'
        [{'code' => '403', 'message' => 'Forbidden'}]
      else
        [{'code' => @request.response.code.to_s, 'message' => 'Unkown Error'}]
      end
    end
  end
end
