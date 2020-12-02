class PasswordLine
  attr_reader :line
  def initialize(line)
    @line = line
  end

  def get
    policy, pass = get_policy_password(line)
    positions, letter = get_times_letter(policy)
    first, second = get_positions(positions)
    [first, second, letter, pass]
  end

private

  def get_policy_password(line)
    line.strip.split(": ")
  end

  def get_times_letter(policy)
    policy.split(" ")
  end

  def get_positions(times)
    times.split("-").map(&:to_i)
  end
end

class PasswordChecker
  def self.run(**args)
    new(**args).run
  end

  attr_reader :input_file
  def initialize(input_file:)
    @input_file = input_file
  end

  def run
    correct = 0
    File.open(input_file).each do |line|
      correct = correct + 1 if matches_policy?(line)
    end
    correct
  end
end

class PasswordCheckerTimes < PasswordChecker
private

  def matches_policy?(line)
    lower, higher, letter, pass = PasswordLine.new(line).get
    pass.count(letter).between?(lower, higher)
  end
end

class PasswordCheckerPositions < PasswordChecker
private

  def matches_policy?(line)
    first, second, letter, pass = PasswordLine.new(line).get
    [pass[first - 1], pass[second - 1]].count(letter) == 1
  end
end

puts "Part 1: #{PasswordCheckerTimes.run(input_file: "input.txt")}"
puts "Part 2: #{PasswordCheckerPositions.run(input_file: "input.txt")}"
