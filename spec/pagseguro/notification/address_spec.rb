require "spec_helper"

describe PagSeguro::Notification::Address do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:address) do
    PagSeguro::Notification::Address.new(xml['address'])
  end

  subject { address }

  its(:street) { should eq('Av. Brig. Faria Lima') }
  its(:number) { should eq('1384') }
  its(:complement) { should eq('5o andar') }
  its(:district) { should eq('Jardim Paulistano') }
  its(:postal_code) { should eq('01452002') }
  its(:city) { should eq('Sao Paulo') }
  its(:state) { should eq('SP') }
  its(:country) { should eq('BRA') }

  let(:xml_file) {
    "<address>
      <street>Av. Brig. Faria Lima</street>
      <number>1384</number>
      <complement>5o andar</complement>
      <district>Jardim Paulistano</district>
      <postalCode>01452002</postalCode>
      <city>Sao Paulo</city>
      <state>SP</state>
      <country>BRA</country>
    </address>"
  }
end
