module PagSeguro
  class Phone
    include ActiveModel::Validations

    validates_presence_of :area_code, :number
    validates_length_of :area_code, is: 2
    validates_length_of :number, in: 7..9

    # Set the area code.
    attr_accessor :area_code

    # Set the phone number.
    # Must have 7-9 numbers.
    attr_accessor :number

    def initialize(area_code, number)
      @area_code = area_code
      @number = number
    end
  end
end
