module PagSeguro
  class Items
    extend Forwardable
    include Enumerable

    def_delegators :@store, :size, :clear, :empty?, :any?, :each

    def initialize
      @store = []
    end

    def <<(item)
      @store << item
    end
  end
end
