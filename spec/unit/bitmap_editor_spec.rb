require 'spec_helper'
require_relative '../../lib/bitmap_editor'

RSpec.describe BitmapEditor do
  let(:writer) { double :writer, write: nil, write_line: nil}
  let(:reader) { double :reader }
  subject { BitmapEditor.new }

  before do
    allow(OutputWriter).to receive(:new).and_return writer
    allow(InputReader).to receive(:new).and_return reader
  end

  describe '#run' do
    it 'keeps reading lines until an X is received' do
      expect(reader).to receive(:read_line).and_return(['A'], ['A'], ['A'], ['X'])
      subject.run
    end

    it 'shows the initial message once' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).once
      expect(reader).to receive(:read_line).and_return(['A'], ['X'])
      subject.run
    end

    it 'shows the line prompt each time it calls read_line' do
      expect(writer).to receive(:write).with(OutputStrings::INPUT_PROMPT).twice
      expect(reader).to receive(:read_line).and_return(['A'], ['X'])
      subject.run
    end

    it 'shows an exit message on exit' do
      expect(writer).to receive(:write_line).with(OutputStrings::EXIT)
      expect(reader).to receive(:read_line).and_return(['X'])
      subject.run
    end

    it 'shows a help message on help' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).ordered
      expect(writer).to receive(:write_line).with(OutputStrings::HELP).ordered
      expect(reader).to receive(:read_line).and_return(['?'], ['X'])
      subject.run
    end
  end
end
