module PagSeguro
  class Session
    class Response
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def id
        @id ||= response['session']['id']
      end
    end
  end
end
