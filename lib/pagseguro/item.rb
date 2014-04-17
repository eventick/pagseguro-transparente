module PagSeguro
  class Item
    include ActiveModel::Validations

    validates_presence_of :id, :description, :amount, :quantity
    validates_numericality_of :amount, :quantity, greater_than: 0
    validates_numericality_of :quantity, only_integer: true

    # Set the product identifier, such as SKU.
    attr_accessor :id

    # Set the product description.
    attr_accessor :description

    # Set the amount per unit.
    attr_accessor :amount

    # Set the quantity.
    # Defaults to 1.
    attr_accessor :quantity

    def initialize(id, description, amount, quantity = 1)
      @id = id
      @description = description
      @amount = amount
      @quantity = quantity
    end
  end
end
