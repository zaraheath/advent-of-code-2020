class YearValidator
  attr_reader :year
  def initialize(year)
    @year = year
  end

  def valid?(num_digits:, start_value:, end_value:)
    year.to_s.size == num_digits && (start_value..end_value).include?(year)
  end
end
