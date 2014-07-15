module PagSeguro
  class Session < Request
    def create
      Response.new post('/sessions').parsed_response
    end
  end
end
