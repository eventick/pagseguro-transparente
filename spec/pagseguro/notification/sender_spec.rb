require "spec_helper"

describe PagSeguro::Notification::Sender do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:sender) do
    PagSeguro::Notification::Sender.new(xml['sender'])
  end

  subject { sender }

  its(:name) { should eq('José Comprador') }
  its(:email) { should eq('comprador@uol.com.br') }
  its(:phone) { should be_a_kind_of(PagSeguro::Notification::Phone) }

  let(:xml_file) {
    "<sender>
      <name>José Comprador</name>
      <email>comprador@uol.com.br</email>
      <phone>
          <areaCode>11</areaCode>
          <number>56273440</number>
      </phone>
    </sender>"
  }
end
