class CasesController < ApplicationController
  respond_to :json
  before_action :before_cases, only: [:index]

  # GET /cases.json
  def index
    render json: cases
  end

  private

  def cases
    case_query = Case

    case_query = case_query.where(status: case_params[:status]) if case_params[:status].present?
    case_query = case_query.where(service: case_params[:category]) if case_params[:category].present?

    if case_params[:near].present?
      origin = case_params[:near].split(',').map(&:to_f)
      case_query = case_query.within(close_to, origin: origin)
    end

    if case_params[:since].present?
      since = Time.at(case_params[:since].to_i)
      case_query = case_query.where("opened_at >= ?", since)
    end

    case_query.all
  end

  def close_to
    ENV['CLOSE_TO'] || 5
  end

  # Only allow a trusted parameter "white list" through.
  def case_params
    params.permit(:since, :status, :category, :near)
  end

  def before_cases
    @errors = []
    valid_near_for_cases if case_params[:near].present?
    render json: ErrorsPresenter.new(@errors), status: 400 if @errors.present?
  end

  def valid_near_for_cases
    near = case_params[:near].split(',').map(&:to_f)
    if near.size != 2
      message  = "Should be latitude and longitude separated by coma: near=47,-122 &"
      message += "decimal part is separated from the integer with a dot.: near=37.77,-122.48"
      @errors << ParameterError.new(message, '101', 'near')
    end
  rescue StandardError => e
    message = "#{e.class} - #{e.message}"
    @errors << ParameterError.new(message, '101', 'near')
  end
end
