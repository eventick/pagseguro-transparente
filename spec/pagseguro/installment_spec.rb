require "spec_helper"

describe PagSeguro::Installment do
  let(:installment) { PagSeguro::Installment.new(12, 100) }
  subject { installment }

  it { should respond_to(:quantity) }
  it { should respond_to(:value) }

  describe 'presence validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:value) }
  end
end
