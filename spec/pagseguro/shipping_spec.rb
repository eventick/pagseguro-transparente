require "spec_helper"

describe PagSeguro::Shipping do
  let(:shipping) { PagSeguro::Shipping.new }
  subject { shipping }

  it { should respond_to(:type_id) }
  it { should respond_to(:cost) }
  it { should respond_to(:address) }

  describe 'presence validations' do
    it { should validate_presence_of(:address) }
  end

  describe 'numericality validations' do
    it { should validate_numericality_of(:cost).is_greater_than(0) }
  end

  describe 'inclusion validations' do
    it { should ensure_inclusion_of(:type_id).in_array( %w( 1 2 3 ) ) }
  end
end
