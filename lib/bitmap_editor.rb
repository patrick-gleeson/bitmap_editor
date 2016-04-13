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
      case input_args[0]
      when '?'
        show_help
      when 'X'
        exit_console
      else
        @writer.write_line OutputStrings::UNRECOGNISED
      end
    end
  end

  private

  def exit_console
    @writer.write_line OutputStrings::EXIT
    @running = false
  end

  def show_help
    @writer.write_line OutputStrings::HELP
  end
end
