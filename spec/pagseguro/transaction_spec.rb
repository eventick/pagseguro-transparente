require "spec_helper"

describe PagSeguro::Transaction do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:response) { PagSeguro::Transaction.new(xml) }

  subject { response }

  context "successful transaction" do

    let(:xml_file) {
      "<transaction>
          <date>2011-02-05T15:46:12.000-02:00</date>
          <lastEventDate>2011-02-15T17:39:14.000-03:00</lastEventDate>
          <code>9E884542-81B3-4419-9A75-BCC6FB495EF1</code>
          <reference>REF1234</reference>
          <type>1</type>
          <status>3</status>
          <paymentLink>https://pagseguro.uol.com.br/checkout/imprimeBoleto.jhtml</paymentLink>
          <grossAmount>49900.00</grossAmount>
          <discountAmount>0.00</discountAmount>
          <feeAmount>0.00</feeAmount>
          <netAmount>49900.50</netAmount>
          <extraAmount>0.00</extraAmount>
          <installmentCount>1</installmentCount>
          <escrowEndDate>2011-02-05T15:46:12.000-02:00</escrowEndDate>
          <cancellationSource>INTERNAL</cancellationSource>
      </transaction>"
    }

    it { should be_valid }
    its(:date) { should eq('2011-02-05T15:46:12.000-02:00') }
    its(:last_event_date) { should eq('2011-02-15T17:39:14.000-03:00') }
    its(:code) { should eq('9E884542-81B3-4419-9A75-BCC6FB495EF1') }
    its(:reference) { should eq('REF1234') }
    its(:type) { should eq('1') }
    its(:status) { should eq('3') }
    its(:status_name) { should eq(:paid) }
    its(:payment_link) { should eq('https://pagseguro.uol.com.br/checkout/imprimeBoleto.jhtml') }
    its(:gross_amount) { should eq('49900.00') }
    its(:discount_amount) { should eq("0.00") }
    its(:fee_amount) { should eq('0.00') }
    its(:net_amount) { should eq('49900.50') }
    its(:extra_amount) { should eq('0.00') }
    its(:installment_count) { should eq("1") }
    its(:payment_method) { should be_a_kind_of(PagSeguro::Transaction::PaymentMethod) }
    its(:items) { should be_a_kind_of(PagSeguro::Transaction::Items) }
    its(:sender) { should be_a_kind_of(PagSeguro::Transaction::Sender) }
    its(:shipping) { should be_a_kind_of(PagSeguro::Transaction::Shipping) }
    its(:escrow_end_date) { should eq('2011-02-05T15:46:12.000-02:00') }
    its(:cancellation_source) { should eq('INTERNAL') }
    its(:errors) { should eq([]) }

  end

  context "unsuccessfull transaction" do
    let(:xml_file) {
      "<errors>
        <error>
          <code>53044</code>
          <message>credit card holder name invalid value: Flora</message>
          </error>
        </errors>"
    }

    it { should_not be_valid}
    its(:errors) { should eq( [ { "code" => "53044", "message" => "credit card holder name invalid value: Flora"} ]) }
  end
end
