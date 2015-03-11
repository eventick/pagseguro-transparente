require "spec_helper"

describe PagSeguro::Transaction::CreditorFees do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:creditor_fee) do
    PagSeguro::Transaction::CreditorFees.new(xml['creditorFees'])
  end

  subject { creditor_fee }

  its(:installment_fee_amount) { should eq(1.00) }
  its(:intermediation_rate_amount) { should eq(2.00) }
  its(:intermediation_fee_amount) { should eq(27.15) }
  its(:fee_amount) { should eq(30.15) }

  let(:xml_file) {
    "<creditorFees>
    <installmentFeeAmount>1.00</installmentFeeAmount>
    <intermediationRateAmount>2.00</intermediationRateAmount>
    <intermediationFeeAmount>27.15</intermediationFeeAmount>
    </creditorFees>"
  }
end
