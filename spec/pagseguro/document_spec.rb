require "spec_helper"

describe PagSeguro::Document do
  let(:document) { PagSeguro::Document.new('017.345.345-00') }
  subject { document }

  it { should respond_to(:type) }
  it { should respond_to(:value) }
  it { should respond_to(:cpf?) }

  describe 'presence validations' do
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:value) }
  end

  describe 'set default country' do
    it { expect(subject.type).to eq('CPF') }
  end

  describe 'inclusion validations' do
    let(:types) { %w(CPF CNPJ) }
    it { should ensure_inclusion_of(:type).in_array(types) }
  end

  describe '#cpf' do
    context 'with CPF' do
      it { expect(subject.cpf?).to be_truthy }
    end

    context 'with CNPJ' do
      let(:document) { PagSeguro::Document.new('017.345.345-00', 'CNPJ') }
      it { expect(subject.cpf?).to be_falsey }
    end
  end
end
