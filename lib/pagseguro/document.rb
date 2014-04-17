module PagSeguro
  class Document
  include ActiveModel::Validations

  validates_presence_of :type, :value

    # Set the document type
    # Only CPF is acceptable
    attr_accessor :type

    # Set the document number.
    # Must have 7-9 numbers.
    attr_accessor :value

    def initialize(value)
      @type = 'CPF'
      @value = value
    end
  end
end
