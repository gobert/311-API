require 'spec_helper'

describe CaseService do
  describe '#crawl_new_cases' do
    let(:service) { described_class.new(2) }

    context 'having existing cases' do
      let(:service_call) do
        VCR.use_cassette("case-service/having-existing/new-cases") do
          service.crawl_new_cases
        end
      end

      before do
        Case.create_from_socrata!('lat' => '52', 'long' => '13', 'requested_datetime' => '2017-09-20T09:44:28')
      end

      it 'imports new cases' do
        expect { service_call }.to change { Case.count }.by(1)
      end
    end
  end
end
