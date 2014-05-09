require "spec_helper"

describe PagSeguro::Transaction::PaymentMethod do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:payment_method) do
    PagSeguro::Transaction::PaymentMethod.new(xml['paymentMethod'])
  end

  subject { payment_method }

  its(:payment_type) { should eq('1') }
  its(:payment_type_name) { should eq(:credit_card) }
  its(:payment_code) { should eq('101') }

  let(:xml_file) {
    "<paymentMethod>
      <type>1</type>
      <code>101</code>
    </paymentMethod>"
  }
end
