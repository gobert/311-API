require 'spec_helper'

describe ParameterError do
  describe '#to_hash' do
    let(:message) { 'Parameter not valid' }
    let(:code)    { 101 }
    let(:field)   { 'near' }
    let(:error)   { described_class.new(message, code, field) }

    it { expect(error.to_hash['message']).to eq(message) }
    it { expect(error.to_hash['code']).to eq(code) }
    it { expect(error.to_hash['field']).to eq(field) }
  end
end
