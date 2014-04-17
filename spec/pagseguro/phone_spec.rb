require "spec_helper"

describe PagSeguro::Phone do
  let(:phone) { PagSeguro::Phone.new('11', '3042-4007') }
  subject { phone }

  it { should respond_to(:area_code) }
  it { should respond_to(:number) }

  describe 'presence validations' do
    it { should validate_presence_of(:area_code) }
    it { should validate_presence_of(:number) }
  end

  describe 'length validations' do
    it { should ensure_length_of(:area_code).is_equal_to(2) }
    it { should ensure_length_of(:number).is_at_least(7).is_at_most(9) }
  end
end
