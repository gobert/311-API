class ParameterError < StandardError
  attr_reader :message, :code, :field

  def initialize(message, code, field)
    @message = message
    @code = code
    @field = field
  end

  def to_hash
    {
      code: code,
      field: field,
      message: message
    }.with_indifferent_access
  end
end
