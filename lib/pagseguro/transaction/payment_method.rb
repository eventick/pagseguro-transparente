module PagSeguro
  class Transaction
    class PaymentMethod
      attr_reader :payment_method

      def initialize(payment_method)
        @payment_method = payment_method
      end

      def payment_type
        payment_method['type']
      end

      def payment_code
        payment_method['code']
      end
    end
  end
end
