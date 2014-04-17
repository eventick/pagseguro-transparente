require "spec_helper"

describe PagSeguro::Item do
  let(:item) { PagSeguro::Item.new('id', 'my item', 10) }
  subject { item }

  it { should respond_to(:id) }
  it { should respond_to(:description) }
  it { should respond_to(:amount) }
  it { should respond_to(:quantity) }

  describe 'presence validations' do
    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'numericality validations' do
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_numericality_of(:quantity).only_integer }
  end

  describe 'set default country' do
    its(:quantity) { should eq(1) }
  end
end
