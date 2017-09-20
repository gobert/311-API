require 'spec_helper'

def date_to_socrata_string(date)
  date.strftime('%Y-%m-%dT%H:%M:%S')
end

describe Case do
  describe '.create_from_socrata!' do
    let(:socrata_data) do
      JSON.parse(
        '{
        "closed_date": "2017-09-12T17:19:00",
        "status_description": "Closed",
        "address": "1 HARRISON ST, SAN FRANCISCO, CA, 94105",
        "service_name": "Street and Sidewalk Cleaning",
        "service_request_id": "8008421",
        "source": "Web",
        "status_notes": "Serviced",
        "supervisor_district": "6",
        "long": "-122.3891",
        "point": {
        "latitude": "37.7891",
        "human_address": "{\"address\":\"\",\"city\":\"\",\"state\":\"\",\"zip\":\"\"}",
        "needs_recoding": false,
        "longitude": "-122.389"
        },
        "agency_responsible": "Recology_Overflowing",
        "service_subtype": "City_garbage_can_overflowing",
        "service_details": "City_garbage_can_overflowing",
        "neighborhoods_sffind_boundaries": "Rincon Hill",
        "requested_datetime": "2017-09-12T09:43:25",
        "updated_datetime": "2017-09-12T17:19:00",
        "police_district": "SOUTHERN",
        "lat": "37.78893"
        }
        '
      )
    end
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
