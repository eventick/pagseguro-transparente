module PagSeguro
  class Bank
    include ActiveModel::Validations

    validates_presence_of :name
    validates_inclusion_of :name, in: %w(bradesco itau bancodobrasil banrisul hsbc)
    # Set the bank name
    # Should be a valid bank: bradesco, itau, bancodobrasil, banrisul ou hsbc
    attr_accessor :name

    def initialize(name)
      @name = name
    end
  end
end
