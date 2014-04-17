require "spec_helper"

describe PagSeguro::Holder do
  let(:holder) { PagSeguro::Holder.new('Cleonice Maria', '31/12/2013') }
  subject { holder }

  it { should respond_to(:name) }
  it { should respond_to(:birthdate) }
  it { should respond_to(:document) }
  it { should respond_to(:phone) }

  describe 'presence validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:birthdate) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:phone) }
  end
end
