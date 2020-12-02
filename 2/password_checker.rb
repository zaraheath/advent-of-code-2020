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
      policy, pass = get_policy_password(line)
      times, letter = get_times_letter(policy)
      lower, higher = get_lower_higher(times)
      correct = correct + 1 if matches_policy?(lower, higher, letter, pass)
    end
    correct
  end

private

  def get_policy_password(line)
    line.strip.split(": ")
  end

  def get_times_letter(policy)
    policy.split(" ")
  end

  def get_lower_higher(times)
    times.split("-").map(&:to_i)
  end

  def matches_policy?(lower, higher, letter, pass)
    pass.count(letter).between?(lower, higher)
  end
end

puts PasswordChecker.run(input_file: "input.txt")
