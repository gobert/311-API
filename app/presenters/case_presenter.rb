class CasePresenter
  attr_reader :case311

  def initialize(case311)
    @case311 = case311
  end

  def to_hash
    {
      id: case311.id,
      remote_id: case311.remote_id,

      status: case311.status,
      status_note: case311.status_note,

      service: case311.service,
      service_subtype: case311.service_subtype,
      service_details: case311.service_details,

      address: case311.address,
      neighborhood: case311.neighborhood,
      police_district: case311.police_district,
      supervisor_district_id: case311.supervisor_district_id,
      lat: case311.lat,
      lng: case311.lng,

      source: case311.source,
      media_url: case311.media_url,
      responsible_agency: case311.responsible_agency,

      opened_at: case311.opened_at.try(:utc).try(:iso8601),
      closed_at: case311.closed_at.try(:utc).try(:iso8601),
      created_at: case311.created_at.try(:utc).try(:iso8601),
      updated_at: case311.updated_at.try(:utc).try(:iso8601),
      remote_updated_at: case311.remote_updated_at.try(:utc).try(:iso8601)
    }.with_indifferent_access
  end
end
