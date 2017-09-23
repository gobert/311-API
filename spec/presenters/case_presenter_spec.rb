require 'spec_helper'

describe CasePresenter do
  describe '#to_hash' do
    let(:fixtures) { file_fixture('case.json').read }
    let(:socrata_data) { JSON.parse(fixtures) }
    let(:case311) { Case.create_from_socrata!(socrata_data) }
    let(:case_presenter) { described_class.new(case311) }

    it { expect(case_presenter.to_hash['id']).to be_present }
    it { expect(case_presenter.to_hash['remote_id']).to eq(case311.remote_id) }

    it { expect(case_presenter.to_hash['status']).to eq(case311.status) }
    it { expect(case_presenter.to_hash['status_note']).to eq(case311.status_note) }

    it { expect(case_presenter.to_hash['service']).to eq(case311.service) }
    it { expect(case_presenter.to_hash['service_subtype']).to eq(case311.service_subtype) }
    it { expect(case_presenter.to_hash['service_details']).to eq(case311.service_details) }

    it { expect(case_presenter.to_hash['address']).to eq(case311.address) }
    it { expect(case_presenter.to_hash['neighborhood']).to eq(case311.neighborhood) }
    it { expect(case_presenter.to_hash['police_district']).to eq(case311.police_district) }
    it { expect(case_presenter.to_hash['supervisor_district_id']).to eq(case311.supervisor_district_id) }
    it { expect(case_presenter.to_hash['lat']).to eq(case311.lat) }
    it { expect(case_presenter.to_hash['lng']).to eq(case311.lng) }

    it { expect(case_presenter.to_hash['source']).to eq(case311.source) }
    it { expect(case_presenter.to_hash['media_url']).to eq(case311.media_url) }
    it { expect(case_presenter.to_hash['responsible_agency']).to eq(case311.responsible_agency) }

    it 'converts opened_at according to UTC and ISO 8601' do
      expect(case_presenter.to_hash['opened_at'].to_s).to eq(case311.opened_at.utc.iso8601.to_s)
    end

    it 'converts closed_at according to UTC and ISO 8601' do
      expect(case_presenter.to_hash['closed_at'].to_s).to eq(case311.closed_at.utc.iso8601.to_s)
    end

    it 'converts updated_at according to UTC and ISO 8601' do
      expect(case_presenter.to_hash['updated_at'].to_s).to eq(case311.updated_at.utc.iso8601.to_s)
    end

    it 'converts remote_updated_at according to UTC and ISO 8601' do
      expect(case_presenter.to_hash['remote_updated_at'].to_s).to eq(case311.remote_updated_at.utc.iso8601.to_s)
    end
  end
end
