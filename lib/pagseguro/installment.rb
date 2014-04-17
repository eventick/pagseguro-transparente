module PagSeguro
  class Installment
    include ActiveModel::Validations
    validates_presence_of :quantity, :value

    # Set the total of installments
    attr_accessor :quantity

    # Set the installment value.
    attr_accessor :value

    def initialize(quantity, value)
      @quantity = quantity
      @value = value
    end
  end
end
