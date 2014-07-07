require "spec_helper"

describe PagSeguro::Query do
  let(:code) { '64C4CB1E-5FF2-4092-BE17-CACE271D789E' }

  let(:query) { PagSeguro::Query.new(code) }
  subject { query  }

  it { should respond_to(:transaction) }

  before do
    PagSeguro.email = 'mail'
    PagSeguro.token = 'token'
  end

  describe "#transaction" do
    subject { query.transaction  }
    before do
      stub_request(:get, "https://ws.pagseguro.uol.com.br/v2/transactions/64C4CB1E-5FF2-4092-BE17-CACE271D789E?email=mail&token=token").
       to_return(:status => 200, :body => "", :headers => {})
    end

    it { should be_a_kind_of(PagSeguro::Transaction) }
  end
end
