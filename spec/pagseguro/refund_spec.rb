require "spec_helper"

describe PagSeguro::Refund do
  let(:transactionCode) { '766B9C-AD4B044B04DA-77742F5FA653-E1AB24' }

  subject(:refund) { PagSeguro::Refund.new(transactionCode) }

  it { should respond_to(:request) }
  it { should respond_to(:errors) }

  before do
    PagSeguro.email = 'mail'
    PagSeguro.token = 'token'
  end

  describe "#request" do

    let(:refund) { PagSeguro::Refund.new(transactionCode) }

    context "successful refund" do
      subject { refund.request }

      before do
        stub_request(:post, "https://ws.pagseguro.uol.com.br/v2/transactions/refunds").
         with(:body => "email=mail&token=token&transactionCode=766B9C-AD4B044B04DA-77742F5FA653-E1AB24").
         to_return(:status => 200, :body => "<?xml version='1.0' encoding='ISO-8859-1' standalone='yes'?> <result>OK</result>", :headers => {'Content-Type' => 'application/xml;charset=ISO-8859-1'})
      end

      it { expect(subject).to be_true }
    end

    context "unsuccessfull refund" do
      let(:single_error) { "<?xml version='1.0' encoding='ISO-8859-1' standalone='yes'?><errors><error><code>14006</code><message>insufficient balance to refund transaction.</message></error></errors>" }
      let(:multiple_errors) { "<?xml version='1.0' encoding='ISO-8859-1' standalone='yes'?><errors><error><code>14006</code><message>insufficient balance to refund transaction.</message></error><error><code>14007</code><message>invalid transaction status to refund.</message></error></errors>" }
      let(:xml_response) { }

      before do
        stub_request(:post, "https://ws.pagseguro.uol.com.br/v2/transactions/refunds").
         with(:body => "email=mail&token=token&transactionCode=766B9C-AD4B044B04DA-77742F5FA653-E1AB24").
         to_return(:status => 400, :body => xml_response, :headers => {'Content-Type' => 'application/xml;charset=ISO-8859-1'})
      end

      context "single error" do
        let(:xml_response) { single_error }

        context "request return" do
          subject { refund.request }

          it { expect(subject).to be_false }
        end

        context "error format" do
          before { refund.request }
          subject { refund.errors }

          it { expect(subject).to eq [ { "code" => "14006", "message" => "insufficient balance to refund transaction."} ] }
        end
      end

      context "various errors" do
        let(:xml_response) { multiple_errors }

        context "request return" do
          subject { refund.request }

          it { expect(subject).to be_false }
        end

        context "error format" do
          before { refund.request }
          subject { refund.errors }

          it { expect(refund.errors).to eq [ { "code" => "14006", "message" => "insufficient balance to refund transaction."}, { "code" => "14007", "message" => "invalid transaction status to refund."} ] }
        end
      end
    end

    context "unexpected response" do
      subject { refund.errors }

      before do
        stub_request(:post, "https://ws.pagseguro.uol.com.br/v2/transactions/refunds").
         with(:body => "email=mail&token=token&transactionCode=766B9C-AD4B044B04DA-77742F5FA653-E1AB24").
         to_return(:status => status, :body => "")
      end

      before { refund.request }

      context '403 Forbbiden' do
        let(:status) { 403 }

        it { expect(refund.errors).to eq [ { "code" => "403", "message" => "Forbidden"} ] }
      end

      context '401 Unauthorized' do
        let(:status) { 401 }

        it { expect(refund.errors).to eq [ { "code" => "401", "message" => "Unkown Error"} ] }
      end
    end
  end
end
