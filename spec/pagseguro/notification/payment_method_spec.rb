require "spec_helper"

describe PagSeguro::Notification::PaymentMethod do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:payment_method) do
    PagSeguro::Notification::PaymentMethod.new(xml['paymentMethod'])
  end

  subject { payment_method }

  its(:payment_type) { should eq('1') }
  its(:payment_code) { should eq('101') }

  let(:xml_file) {
    "<paymentMethod>
      <type>1</type>
      <code>101</code>
    </paymentMethod>"
  }
end
