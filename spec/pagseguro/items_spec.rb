require "spec_helper"

describe PagSeguro::Items do
  let(:items) { PagSeguro::Items.new }
  subject { items }

  it { should respond_to(:<<) }
  it { should respond_to(:size) }
  it { should respond_to(:clear) }
  it { should respond_to(:empty?) }
  it { should respond_to(:any?) }
  it { should respond_to(:each) }
end
