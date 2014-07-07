module PagSeguro
  class Query < Request
    attr_accessor :code, :email, :token

    def initialize(code)
      @code = code
    end

    def transaction
      PagSeguro::Transaction.new get("/transactions/#{code}")
    end
  end
end
