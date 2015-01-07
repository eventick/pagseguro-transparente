module PagSeguro
  class Document
  include ActiveModel::Validations

  validates_presence_of :type, :value
  validates_inclusion_of :type, in: %w(CPF CNPJ)

    # Set the document type
    # CPF or CNPJ is acceptable
    attr_accessor :type

    # Set the document number.
    attr_accessor :value

    def initialize(value, type = 'CPF')
      @type = type
      @value = value
    end

    def cpf?
      type == "CPF"
    end
  end
end
