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
    verify_colour colour

    x_int = Integer(x_coord)
    y_int = Integer(y_coord)

    verify_1_indexed_coordinates x: x_int, y: y_int

    @map[y_int - 1][x_int - 1] = colour
  end

  def edit_column(x_coord, y1_coord, y2_coord, colour)
    return unless @map
    verify_colour colour

    x_int = Integer(x_coord)
    y1_int = Integer(y1_coord)
    y2_int = Integer(y2_coord)

    verify_1_indexed_coordinates x: x_int, y: [y1_int, y2_int]

    @map.each_with_index do |row, index|
      row[x_int - 1] = colour if (y1_int - 1) <= index && (y2_int - 1) >= index
    end
  end

  def edit_row(x1_coord, x2_coord, y_coord, colour)
    return unless @map
    verify_colour colour

    x1_int = Integer(x1_coord)
    x2_int = Integer(x2_coord)
    y_int = Integer(y_coord)

    verify_1_indexed_coordinates x: [x1_int, x2_int], y: y_int

    (x1_int..x2_int).each do |coord|
      @map[y_int - 1][coord - 1] = colour
    end
  end

  private

  def verify_1_indexed_coordinates(x: nil, y: nil)
    Array(x).each { |coord| verify_1_indexed_x_coordinate coord }
    Array(y).each { |coord| verify_1_indexed_y_coordinate coord }
  end

  def verify_1_indexed_x_coordinate(x)
    raise ArgumentError unless x >= 1 && x <= @map.transpose.length
  end

  def verify_1_indexed_y_coordinate(y)
    raise ArgumentError unless y >= 1 && y <= @map.length
  end

  def verify_colour(colour)
    raise ArgumentError unless /\A[A-Z]\z/ =~ colour
  end
end
