class Case < ActiveRecord::Base
  acts_as_mappable

  def self.create_from_socrata!(socrata_attrs)
    attrs = {
      'remote_id' => socrata_attrs['service_request_id'],

      'service'         => socrata_attrs['service_name'],
      'service_subtype' => socrata_attrs['service_subtype'],
      'service_details' => socrata_attrs['service_details'],

      'media_url' => socrata_attrs['media_url'].try(:[], 'url'),
      'source'    => socrata_attrs['source'],

      'lat'             => Float(socrata_attrs['lat']),
      'lng'             => Float(socrata_attrs['long']),
      'address'         => socrata_attrs['address'],
      'neighborhood'    => socrata_attrs['neighborhoods_sffind_boundaries'],
      'police_district' => socrata_attrs['police_district'],

      'status'      => socrata_attrs['status_description'],
      'status_note' => socrata_attrs['status_notes'],

      'responsible_agency'     => socrata_attrs['agency_responsible'],
      'supervisor_district_id' => socrata_attrs['supervisor_district']
    }

    attrs['opened_at'] = Chronic.parse(socrata_attrs['requested_datetime'].tr('T', ' '))

    if socrata_attrs['closed_date'].present?
      attrs['closed_at'] = Chronic.parse(socrata_attrs['closed_date'].tr('T', ' '))
    end
    if socrata_attrs['updated_datetime'].present?
      attrs['remote_updated_at'] = Chronic.parse(socrata_attrs['updated_datetime'].tr('T', ' '))
    end

    create!(attrs)
  end
end
