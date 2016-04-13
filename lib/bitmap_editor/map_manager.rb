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

  def edit_pixel(x_coord, y_coord, colour)
    return unless @map
    raise ArgumentError unless /\A[A-Z]\z/ =~ colour

    x_int = Integer(x_coord)
    y_int = Integer(y_coord)

    verify_1_indexed_coordinates(x_int, y_int)

    @map[y_int - 1][x_int - 1] = colour
  end

  private

  def verify_1_indexed_coordinates(x, y)
    raise ArgumentError unless x >= 1 && x <= @map.transpose.length
    raise ArgumentError unless y >= 1 && y <= @map.length
  end
end
