module PagSeguro
  class Session < Request
    def create(account = nil)
      Response.new post('/sessions', account).parsed_response
    end
  end
end
