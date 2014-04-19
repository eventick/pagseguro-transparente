module PagSeguro
  class Shipping
    include ActiveModel::Validations

    validates_presence_of :address
    validates_inclusion_of :type_id, in: %w( 1 2 3 ), allow_blank: true
    validates_numericality_of :cost, greater_than: 0, allow_nil: true

    # Set the shipping type
    attr_accessor :type_id

    # Set the credit card holder bithdate.
    attr_accessor :cost

    # Get the sender address.
    attr_accessor :address

    def initialize(type_id = nil, cost = nil)
      @type_id = type_id
      @cost = cost
    end
  end
end
