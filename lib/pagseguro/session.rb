module PagSeguro
  class Session < Request
    def create(account = nil)
      Response.new post('/sessions', API_V2, account).parsed_response
    end
  end
end
