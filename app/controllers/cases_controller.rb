class CasesController < ApplicationController
  respond_to :json

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
end
