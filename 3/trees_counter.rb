class TreesCounter
  INCREMENT_X = 3
  INCREMENT_Y = 1

  def self.run(**args)
    new(**args).run
  end

  attr_reader :matrix
  def initialize(input_file:)
    @matrix = load_matrix(input_file)
  end

  def run
    x = INCREMENT_X
    y = INCREMENT_Y
    trees = 0
    while !matrix[y].nil? && !matrix[y][x].nil?
      if matrix[y][x] == "#"
        trees = trees + 1
      end
      y = y + INCREMENT_Y
      x = x + INCREMENT_X
      if matrix[y].nil?
        break
      end
      if x > (matrix[y].size - 1)
        x = x - (matrix[y].size)
      end
    end
    trees
  end

  def load_matrix(input_file)
    array = []
    File.open(input_file).each do |line|
      array << line.strip.split("")
    end
    array
  end
end

puts "Trees: #{TreesCounter.run(input_file: "input.txt")}"
