require "spec_helper"

describe PagSeguro::Bank do
  let(:bank) { PagSeguro::Bank.new(:itau) }
  subject { bank }

  it { should respond_to(:name) }

  describe 'presence validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'inclusion validations' do
    let(:banks) { %w(bradesco itau bancodobrasil banrisul hsbc) }
    it { should ensure_inclusion_of(:name).in_array(banks) }
  end
end
