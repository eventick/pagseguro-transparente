module PagSeguro
  class Session < Request
    attr_accessor :token, :email

    def create
      Response.new post('/sessions', email, token)
    end

    def initialize(email = nil, token = nil)
      @email = email
      @token = token
    end
  end
end
