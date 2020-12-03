class TreesCounter
  def self.run(**args)
    new(**args).run
  end

  attr_reader :matrix, :increment_x, :increment_y
  def initialize(input_file:, increment_x:, increment_y:)
    @matrix = load_matrix(input_file)
    @increment_x = increment_x
    @increment_y = increment_y
  end

  def run
    x = increment_x
    y = increment_y
    trees = 0
    while !matrix[y].nil? && !matrix[y][x].nil?
      if matrix[y][x] == "#"
        trees = trees + 1
      end
      y = y + increment_y
      x = x + increment_x
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

result = []
[[1,1], [3,1], [5,1], [7,1], [1,2]].each do |increment|
  trees = TreesCounter.run(input_file: "input.txt", increment_x: increment.first, increment_y: increment.last)
  puts "Trees (#{increment.first},#{increment.last}) = #{trees}"
  result << trees
end
puts "Final result: #{result.inject(:*)}"
