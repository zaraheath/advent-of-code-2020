class YearValidator
  attr_reader :year
  def initialize(year)
    @year = year
  end

  def valid?(num_digits:, start_value:, end_value:)
    year.to_s.size == num_digits && (start_value..end_value).include?(year)
  end
end

class Year
  def self.valid?(year_str)
    new(year_str).valid?
  end

  attr_reader :year
  def initialize(year_str)
    @year = year_str.to_i
  end
end

class Byr < Year
  def valid?
    YearValidator.new(year).valid?(num_digits: 4, start_value: 1920, end_value: 2002)
  end
end

class Iyr < Year
  def valid?
    YearValidator.new(year).valid?(num_digits: 4, start_value: 2010, end_value: 2020)
  end
end

class Eyr < Year
  def valid?
    YearValidator.new(year).valid?(num_digits: 4, start_value: 2020, end_value: 2030)
  end
end

class Hgt
  VALID_CM = 150..193
  VALID_IN = 59..76

  def self.valid?(height)
    new(height).valid?
  end

  attr_reader :height
  def initialize(height)
    @height = height
  end

  def valid?
    if height.include?("cm")
      VALID_CM.include?(height.split("cm").first.to_i)
    elsif height.include?("in")
      VALID_IN.include?(height.split("in").first.to_i)
    else
      false
    end
  end
end

class Hcl
  def self.valid?(height)
    new(height).valid?
  end

  attr_reader :hair_colour
  def initialize(hair_colour)
    @hair_colour = hair_colour
  end

  def valid?
    hair_colour.match(/^#[0-9a-f]{6}$/)
  end
end

class Ecl
  def self.valid?(height)
    new(height).valid?
  end

  VALID_EYECOLOURS = %w[amb blu brn gry grn hzl oth]

  attr_reader :eye_colour
  def initialize(eye_colour)
    @eye_colour = eye_colour
  end

  def valid?
    VALID_EYECOLOURS.include?(eye_colour)
  end
end

class Pid
  def self.valid?(height)
    new(height).valid?
  end

  attr_reader :pid
  def initialize(pid)
    @pid = pid
  end

  def valid?
    pid.match(/^\d{9}$/)
  end
end

class Cid
  def self.valid?(str)
    true # Always valid, optional
  end
end

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
    required_fields = 0
    valid_passports = 0
    passports.each do |passport|
      fields = find_values(passport)
      fields_keys = fields.map{|item| item.split(":").first}
      if (REQUIRED_FIELDS - fields_keys).empty?
        required_fields = required_fields + 1
        valid_passports = valid_passports + 1 if valid_passport(fields)
      end
    end
    [required_fields, valid_passports]
  end

  def find_values(passport)
    passport.join(" ").split(" ")
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

  def valid_passport(fields)
    result = true
    fields.each do |field|
      unless Object.const_get(field.split(":").first.capitalize).valid?(field.split(":").last)
        result = false
        break
      end
    end
    result
  end
end

checks = PassportChecker.run(input_file: "input.txt")
puts "Part 1: #{checks.first}\n"
puts "Part 2: #{checks.last}\n"
