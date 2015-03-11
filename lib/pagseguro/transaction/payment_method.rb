module PagSeguro
  class Transaction
    class PaymentMethod
      attr_reader :payment_method

      PAYMENT_TYPE = { '1' => :credit_card, '2' => :boleto, '3' => :tef,
        '4' => :pagseguro_balance, '5' => :io_paggo, '7' => :deposit }

      def initialize(payment_method)
        @payment_method = payment_method
      end

      def payment_type
        payment_method['type']
      end

      def payment_type_name
        PAYMENT_TYPE[payment_type]
      end

      def payment_code
        payment_method['code']
      end
    end
  end
end
