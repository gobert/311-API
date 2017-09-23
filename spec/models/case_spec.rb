require 'spec_helper'

def date_to_socrata_string(date)
  date.strftime('%Y-%m-%dT%H:%M:%S')
end

describe Case do
  describe '.create_from_socrata!' do
    let(:fixtures)     { file_fixture('case.json').read }
    let(:socrata_data) { JSON.parse(fixtures) }
    let(:case311) { described_class.last }

    before { described_class.create_from_socrata!(socrata_data) }

    it { expect(case311.remote_id.to_s).to eq(socrata_data['service_request_id']) }
    it { expect(case311.service).to eq(socrata_data['service_name']) }
    it { expect(case311.service_subtype).to eq(socrata_data['service_subtype']) }
    it { expect(case311.service_details).to eq(socrata_data['service_details']) }
    it { expect(case311.media_url).to eq(socrata_data['media_url']) }
    it { expect(case311.source).to eq(socrata_data['source']) }
    it { expect(case311.address).to eq(socrata_data['address']) }
    it { expect(case311.neighborhood).to eq(socrata_data['neighborhoods_sffind_boundaries']) }
    it { expect(case311.police_district).to eq(socrata_data['police_district']) }
    it { expect(case311.lat.to_s).to eq(socrata_data['lat']) }
    it { expect(case311.lng.to_s).to eq(socrata_data['long']) }
    it { expect(case311.status).to eq(socrata_data['status_description']) }
    it { expect(case311.status_note).to eq(socrata_data['status_notes']) }
    it { expect(case311.responsible_agency).to eq(socrata_data['agency_responsible']) }
    it { expect(case311.supervisor_district_id.to_s).to eq(socrata_data['supervisor_district']) }
    it { expect(date_to_socrata_string(case311.opened_at)).to eq(socrata_data['requested_datetime']) }
    it { expect(date_to_socrata_string(case311.closed_at)).to eq(socrata_data['closed_date']) }
    it { expect(date_to_socrata_string(case311.remote_updated_at)).to eq(socrata_data['updated_datetime']) }
  end
end
