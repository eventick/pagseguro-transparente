require "spec_helper"

describe PagSeguro::Sender do
  let(:sender) { PagSeguro::Sender.new }
  subject { sender }

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:hash_id) }
  it { should respond_to(:document) }
  it { should respond_to(:phone) }

  describe 'presence validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:hash_id) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:phone) }
  end
end
