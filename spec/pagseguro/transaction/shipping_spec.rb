require "spec_helper"

describe PagSeguro::Transaction::Shipping do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:shipping) do
    PagSeguro::Transaction::Shipping.new(xml['shipping'])
  end

  subject { shipping }

  its(:type) { should eq('1') }
  its(:cost) { should eq('21.50') }
  its(:address) { should be_a_kind_of(PagSeguro::Transaction::Address) }

  let(:xml_file) {
    "<shipping>
      <type>1</type>
      <cost>21.50</cost>
    </shipping>"
  }
end
