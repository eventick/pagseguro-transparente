module PagSeguro
  class Notification < Request
    attr_accessor :code

    attr_accessor :type

    def initialize(code, type = nil)
      @code = code
      @type = type
    end

    def transaction
      PagSeguro::Transaction.new post("/transactions/notifications/#{code}")
    end
  end
end
