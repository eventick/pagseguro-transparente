require "spec_helper"

describe PagSeguro::Transaction::Serializer do
  let(:params) { PagSeguro::Transaction::Serializer.new(transaction).to_params }
  subject { params }

  let(:options) {
    {
      notification_url: 'https://sualoja.com.br/notifica.html',
      payment_method: 'boleto',
      reference: 'REF1234',
      extra_amount: '1.00'
    }
  }

  let(:transaction) do
    transaction = PagSeguro::Transaction.new(options)
    transaction.sender = sender
    transaction.shipping = shipping
    transaction.credit_card = credit_card
    transaction.bank = bank
    transaction.items = [PagSeguro::Item.new('0001', 'Notebook Prata', '24300.00', '1') ,
    PagSeguro::Item.new('0002', 'Notebook Rosa', '25600.00', '2') ]
    transaction
  end

  let(:document) { PagSeguro::Document.new('22111944785') }
  let(:phone) {PagSeguro::Phone.new('11', '56273440') }
  let(:sender) do
    sender = PagSeguro::Sender.new({
      email: 'comprador@uol.com.br',
      name: 'Jose Comprador',
      hash_id: 'abc123'
    })
    sender.phone = phone
    sender.document = document
    sender
  end

  let(:address) do
    PagSeguro::Address.new({
        postal_code: '01452002',
        street: 'Av. Brig. Faria Lima',
        number: '1384',
        complement: '5o andar',
        district: 'Jardim Paulistano',
        city: 'Sao Paulo',
        state: 'SP'
      })
  end

  let(:shipping){
    shipping = PagSeguro::Shipping.new('1', '1.00')
    shipping.address = address
    shipping
  }


  let(:installment) { PagSeguro::Installment.new('5', '125.22')}

  let(:holder) do
    holder = PagSeguro::Holder.new('Jose Comprador', '27/10/1987')
    holder.document = document
    holder.phone = phone
    holder
  end

  let(:credit_card) do
    credit_card = PagSeguro::CreditCard.new('4as56d4a56d456as456dsa')
    credit_card.installment = installment
    credit_card.holder = holder
    credit_card.billing_address = address
    credit_card
  end
  before do
  PagSeguro.email = 'pagseguro@eventick.com.br'
  PagSeguro.token = 'my_token'
  end
  let(:bank) { PagSeguro::Bank.new('bancodobrasil') }

  it { subject[:email].should eq('pagseguro@eventick.com.br') }
  it { subject[:token].should eq('my_token') }
  it { subject[:paymentMode].should eq('default') }
  it { subject[:paymentMethod].should eq('boleto') }
  it { subject[:currency].should eq('BRL') }
  it { subject[:extraAmount].should eq('1.00') }
  it { subject[:notificationURL].should eq('https://sualoja.com.br/notifica.html') }
  it { subject[:reference].should eq('REF1234') }
  it { subject[:senderName].should eq('Jose Comprador') }
  it { subject[:senderCPF].should eq('22111944785') }
  it { subject[:senderAreaCode].should eq('11') }
  it { subject[:senderPhone].should eq('56273440') }
  it { subject[:senderEmail].should eq('comprador@uol.com.br') }
  it { subject[:senderHash].should eq('abc123') }
  it { subject[:shippingAddressStreet].should eq('Av. Brig. Faria Lima') }
  it { subject[:shippingAddressNumber].should eq('1384') }
  it { subject[:shippingAddressComplement].should eq('5o andar') }
  it { subject[:shippingAddressDistrict].should eq('Jardim Paulistano') }
  it { subject[:shippingAddressPostalCode].should eq('01452002') }
  it { subject[:shippingAddressCity].should eq('Sao Paulo') }
  it { subject[:shippingAddressState].should eq('SP') }
  it { subject[:shippingAddressCountry].should eq('BRA') }
  it { subject[:shippingType].should eq('1') }
  it { subject[:shippingCost].should eq('1.00') }
  it { subject[:creditCardToken].should eq('4as56d4a56d456as456dsa') }
  it { subject[:installmentQuantity].should eq('5') }
  it { subject[:installmentValue].should eq('125.22') }
  it { subject[:creditCardHolderName].should eq('Jose Comprador') }
  it { subject[:creditCardHolderCPF].should eq('22111944785') }
  it { subject[:creditCardHolderBirthDate].should eq('27/10/1987') }
  it { subject[:creditCardHolderAreaCode].should eq('11') }
  it { subject[:creditCardHolderPhone].should eq('56273440') }

  it { subject[:billingAddressStreet].should eq('Av. Brig. Faria Lima') }
  it { subject[:billingAddressNumber].should eq('1384') }
  it { subject[:billingAddressComplement].should eq('5o andar') }
  it { subject[:billingAddressDistrict].should eq('Jardim Paulistano') }
  it { subject[:billingAddressPostalCode].should eq('01452002') }
  it { subject[:billingAddressCity].should eq('Sao Paulo') }
  it { subject[:billingAddressState].should eq('SP') }
  it { subject[:billingAddressCountry].should eq('BRA') }

  it { subject[:itemId1].should eq('0001') }
  it { subject[:itemDescription1].should eq('Notebook Prata') }
  it { subject[:itemAmount1].should eq('24300.00') }
  it { subject[:itemQuantity1].should eq('1') }
  it { subject[:itemId2].should eq('0002') }
  it { subject[:itemDescription2].should eq('Notebook Rosa') }
  it { subject[:itemAmount2].should eq('25600.00') }
  it { subject[:itemQuantity2].should eq('2') }
end
