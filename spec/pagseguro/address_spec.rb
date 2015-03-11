require "spec_helper"

describe PagSeguro::Address do
  let(:address) { PagSeguro::Address.new }
  subject { address }

  it { should respond_to(:postal_code) }
  it { should respond_to(:street) }
  it { should respond_to(:number) }
  it { should respond_to(:complement) }
  it { should respond_to(:district) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:country) }

  describe 'presence validations' do
    it { should validate_presence_of(:postal_code) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:district) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:country) }
  end

  describe 'length validations' do
    it { should ensure_length_of(:country).is_equal_to(3) }
    it { should ensure_length_of(:state).is_equal_to(2) }
    it { should ensure_length_of(:postal_code).is_equal_to(8) }
  end

  describe 'set default country' do
    it { expect(subject.country).to eq('BRA') }
  end
end
