require "spec_helper"

describe PagSeguro::Notification::Item do
  let(:item) do
    PagSeguro::Notification::Item.new('0001', 'Notebook Prata',
     '1', '24300.00')
  end

  subject { item }

  its(:id) { should eq('0001') }
  its(:description) { should eq('Notebook Prata') }
  its(:quantity) { should eq('1') }
  its(:amount) { should eq('24300.00') }
end
