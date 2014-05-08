module PagSeguro
  class Transaction
    class Shipping
      attr_reader :shipping

      def initialize(shipping)
        @shipping = shipping
      end

      def address
        Address.new(shipping['address'])
      end

      def type
        shipping['type']
      end

      def cost
        shipping['cost']
      end
    end
  end
end
