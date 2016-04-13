require_relative 'bitmap_editor/output_writer'
require_relative 'bitmap_editor/input_reader'
require_relative 'bitmap_editor/output_strings'

class BitmapEditor
  def initialize
    @writer = OutputWriter.new
    @reader = InputReader.new
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
    'X' => :exit_console
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
end
