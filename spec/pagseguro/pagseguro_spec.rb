require "spec_helper"

describe PagSeguro do
  before do
    PagSeguro.email = "EMAIL"
    PagSeguro.token = "TOKEN"
    PagSeguro.timeout = 10
  end

  it { expect(PagSeguro.email).to eql("EMAIL") }
  it { expect(PagSeguro.token).to eql("TOKEN") }
  it { expect(PagSeguro.timeout).to eql(10) }

  context "configuring library" do
    it "yields PagSeguro" do
      expect {|block|
        PagSeguro.configure(&block)
      }.to yield_with_args(PagSeguro)
    end
  end

  context "default settings" do
    it { expect(PagSeguro.environment).to eql(:production) }
  end
end
