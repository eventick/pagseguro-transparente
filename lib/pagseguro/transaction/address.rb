module PagSeguro
  class Transaction
    class Address
      attr_reader :address

      def initialize(address)
        @address = address
      end

      def street
        address['street']
      end

      def number
        address['number']
      end

      def complement
        address['complement']
      end

      def district
        address['district']
      end

      def postal_code
        address['postalCode']
      end

      def city
        address['city']
      end

      def state
        address['state']
      end

      def country
        address['country']
      end
    end
  end
end
