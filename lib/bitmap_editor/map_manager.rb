require 'matrix'

class MapManager
  def create_map(rows, columns)
    row_int = Integer(rows)
    col_int = Integer(columns)
    raise ArgumentError unless row_int >= 1 && row_int <= 250
    raise ArgumentError unless col_int >= 1 && col_int <= 250

    @map = Matrix.build(col_int, row_int) { 'O' }.to_a
  end

  def each_row_as_string
    return unless @map
    @map.each do |row|
      yield row.join
    end
  end
end
