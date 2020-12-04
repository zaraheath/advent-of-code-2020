class PassportChecker
  REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid]

  def self.run(**args)
    new(**args).run
  end

  attr_reader :input_file
  def initialize(input_file:)
    @input_file = input_file
  end

  def run
    check_passports(load_passports)
  end

private

  def check_passports(passports)
    valid = 0
    passports.each do |passport|
      fields = passport.join(" ").split(" ").map{|item| item.split(":").first}
      valid = valid + 1 if (REQUIRED_FIELDS - fields).empty?
    end
    valid
  end

  def load_passports
    array = []
    i = 0
    File.open(input_file).each do |line|
      unless line.strip == ""
        array[i] = [] if array[i].nil?
        array[i] << line.strip
      else
        i = i + 1
      end
    end
    array
  end
end

puts PassportChecker.run(input_file: "input.txt")
