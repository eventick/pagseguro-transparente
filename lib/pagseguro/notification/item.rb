module PagSeguro
  class Notification
    class Item
      attr_accessor :id, :description, :quantity, :amount

      def initialize(id, description, quantity, amount)
        @id = id
        @description = description
        @quantity = quantity
        @amount = amount
      end
    end
  end
end
