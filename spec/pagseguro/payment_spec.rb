require "spec_helper"

describe PagSeguro::Payment do
  subject { payment }

  let(:options) {
    {
      notification_url: 'www.eventick.com.br',
      payment_method: payment_method,
      reference: '0001',
      extra_amount: '1.00'
    }
  }

  let(:payment_method) { 'boleto' }

  let(:payment) do
    payment = PagSeguro::Payment.new(options)
    payment.sender = sender
    payment.shipping = shipping
    payment.items = [PagSeguro::Item.new(id: 1, description: 'Ingresso Teste', amount: 2, quantity: 1)]
    payment
  end


  let(:document) { PagSeguro::Document.new('017.355.323-00') }
  let(:phone) {PagSeguro::Phone.new('11', '99999999') }
  let(:sender) do
    sender = PagSeguro::Sender.new({
      email: 'produtor@eventick.com.br',
      name: 'João do evento',
      hash_id: 'abc1234'
    })
    sender.phone = phone
    sender.document = document
    sender
  end

  let(:address) do
    PagSeguro::Address.new({
        postal_code: '01452002',
        street: 'Rua Fernando de Albuquerque',
        number: '35',
        complement: '31',
        district: 'Consolação',
        city: 'São Paulo',
        state: 'SP'
      })
  end

  let(:shipping){
    shipping = PagSeguro::Shipping.new
    shipping.address = address
    shipping
  }

  it { should respond_to(:receiver_email) }
  it { should respond_to(:notification_url) }
  it { should respond_to(:currency) }
  it { should respond_to(:payment_method) }
  it { should respond_to(:payment_mode) }
  it { should respond_to(:items) }
  it { should respond_to(:reference) }
  it { should respond_to(:extra_amount) }
  it { should respond_to(:sender) }
  it { should respond_to(:shipping) }
  it { should respond_to(:bank) }
  it { should respond_to(:credit_card) }

  describe 'presence validations' do
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:payment_method) }
    it { should validate_presence_of(:sender) }
    it { should validate_presence_of(:shipping) }
  end

  describe 'inclusion validations' do
    let(:payment_methods) { %w(creditCard boleto eft) }
    it { should ensure_inclusion_of(:payment_method).in_array(payment_methods) }
  end

  context 'eft' do
    let(:payment_method) { 'eft' }
    it { should validate_presence_of(:bank) }
  end

  context 'credit card' do
    let(:payment_method) { 'creditCard' }
    it { should validate_presence_of(:credit_card) }
  end
end
