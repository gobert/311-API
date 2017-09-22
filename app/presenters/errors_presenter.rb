class ErrorsPresenter
  attr_reader :error

  def initialize(errors)
    @errors = errors
  end

  def to_hash
    {
      code: 1,
      message: "Parameter validation failed",
      errors: @errors.map(&:to_hash)
    }.with_indifferent_access
  end
end
