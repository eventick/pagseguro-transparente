module PagSeguro
  class Query < Request
    attr_accessor :code, :email, :token

    def initialize(code)
      @code = code
    end

    def transaction(account = nil)
      PagSeguro::Transaction.new get("/transactions/#{code}", account)
    end
  end
end
