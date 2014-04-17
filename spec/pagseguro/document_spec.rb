require "spec_helper"

describe PagSeguro::Document do
  let(:document) { PagSeguro::Document.new('017.345.345-00') }
  subject { document }

  it { should respond_to(:type) }
  it { should respond_to(:value) }

  describe 'presence validations' do
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:value) }
  end

  describe 'set default country' do
    its(:type) { should eq('CPF') }
  end
end
