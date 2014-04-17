require "spec_helper"

describe PagSeguro::Notification::Phone do
  let(:xml) { MultiXml.parse(xml_file) }

  let(:phone) do
    PagSeguro::Notification::Phone.new(xml['phone'])
  end

  subject { phone }

  its(:area_code) { should eq('11') }
  its(:number) { should eq('56273440') }

  let(:xml_file) {
    "<phone>
        <areaCode>11</areaCode>
        <number>56273440</number>
      </phone>"
  }
end
