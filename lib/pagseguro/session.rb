module PagSeguro
  class Session < Request
    def create
      Response.new post('/sessions')
    end
  end
end
