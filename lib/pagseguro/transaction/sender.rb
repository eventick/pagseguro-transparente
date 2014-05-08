module PagSeguro
  class Transaction
    class Sender
      attr_reader :sender

      def initialize(sender)
        @sender = sender
      end

      def name
        sender['name']
      end

      def email
        sender['email']
      end

      def phone
        Phone.new(sender['phone'])
      end
    end
  end
end
