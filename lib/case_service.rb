class CaseService
  attr_reader :limit

  def initialize(limit = 1_000)
    @limit = limit
  end

  def crawl_new_cases
    loop.with_index do |_, i|
      Rails.logger.info "#{Time.now.utc} - Importing batch of cases #{i}"

      soql_params = {
        :$offset => i * limit,
        :$limit => limit,
        :$order => 'requested_datetime DESC'
      }
      soql_params[:$where] = "requested_datetime > '#{border.strftime('%Y-%m-%dT%H:%M:%S')}'" if border.present?

      results = client.get("#{dataset_id}.json", soql_params)

      results.each { |case_attr| Case.create_from_socrata!(case_attr) }

      break if results.blank?
    end
  end

  private

  def app_token
    @app_token ||= ENV['SODA_TOKEN'] || 'dQ2wTKiOxem95rJa9LwluYwxN'
  end

  def client
    @client ||= SODA::Client.new(domain: 'data.sfgov.org', app_token: app_token)
  end

  def border
    @border ||= Case.order('opened_at DESC').first.try(:opened_at) || Time.new(0)
  end

  def dataset_id
    'vw6y-z8j6'
  end
end
