require "spec_helper"

describe PagSeguro::Session::Response do
  let(:xml) do
    MultiXml.parse('<session><id>620f99e348c24f07877c927b353e49d3</id></session>')
  end

  let(:session) { PagSeguro::Session::Response.new(xml) }

  subject { session }

  it { should respond_to(:id) }

  describe '#id' do
    its(:id) { should eq('620f99e348c24f07877c927b353e49d3') }
  end
end
