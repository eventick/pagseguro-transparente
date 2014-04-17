require "spec_helper"

describe PagSeguro::Notification::Items do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:items) do
    PagSeguro::Notification::Items.new(xml['items'], '2')
  end

  subject { items }

  its(:items) { should be_a_kind_of(Array) }
  its(:count) { should eq('2') }

  let(:xml_file) {
    "<items>
      <item>
          <id>0001</id>
          <description>Notebook Prata</description>
          <quantity>1</quantity>
          <amount>24300.00</amount>
      </item>
      <item>
          <id>0002</id>
          <description>Notebook Rosa</description>
          <quantity>1</quantity>
          <amount>25600.00</amount>
      </item>
    </items>"
  }
end
