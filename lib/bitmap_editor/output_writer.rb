class OutputWriter
  def initialize(output = $stdout)
    @output = output
  end

  def write(content)
    @output.print(content)
  end

  def write_line(content)
    @output.puts(content)
  end
end
