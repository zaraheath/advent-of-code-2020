class Year
  def self.valid?(year_str)
    new(year_str).valid?
  end

  attr_reader :year
  def initialize(year_str)
    @year = year_str.to_i
  end
end
