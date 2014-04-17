module PagSeguro
  class Holder
    include ActiveModel::Validations

    validates_presence_of :name, :birthdate, :document, :phone

    # Set the credit card holder name.
    attr_accessor :name

    # Set the credit card holder bithdate.
    attr_accessor :birthdate

    # Set the credit card holder document.
    attr_accessor :document

    # Get the sender phone.
    attr_accessor :phone

    def initialize(name, birthdate)
      @name = name
      @birthdate = birthdate
    end
  end
end
