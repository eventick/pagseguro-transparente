module PagSeguro
  class Notification
    class Phone
      attr_reader :phone

      def initialize(phone)
        @phone = phone
      end

      def area_code
        phone['areaCode']
      end

      def number
        phone['number']
      end
    end
  end
end
