module PagSeguro
  class Address
    include ActiveModel::Validations
    validates_presence_of :postal_code, :street, :number
    validates_presence_of :district, :city, :state, :country

    validates_length_of :country, is: 3
    validates_length_of :state, is: 2
    validates_length_of :postal_code, is: 8
    # Set the postal_code.
    # 8 digit number represeting a valid CEP i.e 01452002
    attr_accessor :postal_code

    # Set the street name.
    attr_accessor :street

    # Set the number.
    attr_accessor :number

    # Get the complement.
    attr_accessor :complement

    # Get the district.
    attr_accessor :district

    # Get the city.
    attr_accessor :city

    # Get the state.
    attr_accessor :state

    # Get the country.
    attr_accessor :country

    def initialize(options = {})
      @country = "BRA"
      @postal_code = options[:postal_code]
      @street = options[:street]
      @number = options[:number]
      @complement = options[:complement]
      @district = options[:district]
      @city = options[:city]
      @state = options[:state]
    end
  end
end
