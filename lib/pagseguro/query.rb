module PagSeguro
  class Query < Request
    attr_accessor :code, :email, :token

    def initialize(code)
      @code = code
    end

    def transaction(account = nil)
      PagSeguro::Transaction.new get("/transactions/#{code}", API_V3,account)
    end
  end
end
