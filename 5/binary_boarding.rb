class BinaryBoarding
  attr_reader :input_file
  def initialize(input_file:)
    @input_file = input_file
  end

  def run
    seats = [] 
    File.open(input_file).each do |line|
      seats << calculate_seat(line)
    end
    missing_seat(seats)
  end

private

  def calculate_seat(line)
    row(line) * 8 + column(line)
  end

  def column(line)
    line[7,9].gsub("L", "0").gsub("R", "1").to_i(2)
  end

  def row(line)
    line[0,7].gsub("F", "0").gsub("B", "1").to_i(2)
  end

  def missing_seat(seats)
    missing_seat = nil
    seats.sort!.each_with_index do |seat, i|
      if seats[i + 1] == (seat + 2)
        missing_seat = seat + 1
        break
      end
    end
    missing_seat
  end
end

puts BinaryBoarding.new(input_file: "input.txt").run
