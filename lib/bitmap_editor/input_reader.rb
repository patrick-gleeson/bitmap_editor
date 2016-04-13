class InputReader
  def initialize(input = $stdin)
    @input = input
  end

  def read_line
    @input.gets.chomp.split
  end
end
