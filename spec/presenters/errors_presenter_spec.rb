require 'spec_helper'

describe ErrorsPresenter do
  describe '#to_hash' do
    let(:message) { 'Parameter not valid' }
    let(:code)    { 101 }
    let(:field)   { 'near' }
    let(:error)   { ParameterError.new(message, code, field) }
    let(:error_presenter) { described_class.new([error]) }

    it { expect(error_presenter.to_hash['code']).to eq(1) }
    it { expect(error_presenter.to_hash['message']).to eq('Parameter validation failed') }
    it { expect(error_presenter.to_hash['errors']).to eq([error.to_hash]) }
  end
end
