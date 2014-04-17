require "spec_helper"

describe PagSeguro::CreditCard do
  let(:card) { PagSeguro::CreditCard.new('card_token') }
  subject { card }

  it { should respond_to(:token) }
  it { should respond_to(:installment) }
  it { should respond_to(:holder) }
  it { should respond_to(:billing_address) }

  describe 'presence validations' do
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:installment) }
    it { should validate_presence_of(:holder) }
    it { should validate_presence_of(:billing_address) }
  end
end
