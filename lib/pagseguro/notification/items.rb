module PagSeguro
  class Notification
    class Items
      attr_reader :count

      def initialize(store, count)
        @store = store
        @count = count
      end

      def items
        @store['item'].map do |i|
          Item.new(i['id'], i['description'], i['quantity'], i['amount'])
        end
      end
    end
  end
end
