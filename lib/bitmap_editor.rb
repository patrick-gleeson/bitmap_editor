require_relative 'bitmap_editor/output_writer'
require_relative 'bitmap_editor/input_reader'
require_relative 'bitmap_editor/output_strings'
require_relative 'bitmap_editor/map_manager'

class BitmapEditor
  def initialize
    @writer = OutputWriter.new
    @reader = InputReader.new
    @manager = MapManager.new
  end

  def run
    @running = true
    @writer.write_line OutputStrings::INITIAL_PROMPT
    while @running
      @writer.write OutputStrings::INPUT_PROMPT
      input_args = @reader.read_line
      action_input input_args
    end
  end

  private

  COMMAND_MAP = {
    '?' => :show_help,
    'X' => :exit_console,
    'I' => :create_map,
    'S' => :print_map,
    'L' => :edit_pixel,
    'V' => :edit_column,
    'H' => :edit_row,
    'C' => :clear_map
  }.freeze

  def action_input(input_args)
    if (command = COMMAND_MAP[input_args[0]])
      send(command, input_args.drop(1))
    else
      @writer.write_line OutputStrings::UNRECOGNISED
    end
  end

  def exit_console(_args)
    @writer.write_line OutputStrings::EXIT
    @running = false
  end

  def show_help(_args)
    @writer.write_line OutputStrings::HELP
  end

  def create_map(args)
    @manager.create_map(*args)
  rescue ArgumentError
    @writer.write_line OutputStrings::INVALID
  end

  def print_map(_args)
    @manager.each_row_as_string do |row_string|
      @writer.write_line row_string
    end
  end

  def edit_pixel(args)
    @manager.edit_pixel(*args)
  rescue ArgumentError
    @writer.write_line OutputStrings::INVALID
  end

  def edit_column(args)
    @manager.edit_column(*args)
  rescue ArgumentError
    @writer.write_line OutputStrings::INVALID
  end

  def edit_row(args)
    @manager.edit_row(*args)
  rescue ArgumentError
    @writer.write_line OutputStrings::INVALID
  end

  def clear_map(_args)
    @manager.clear_map
  end
end
