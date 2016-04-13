require 'spec_helper'
require_relative '../../lib/bitmap_editor'

RSpec.describe BitmapEditor do
  let(:writer) { double :writer, write: nil, write_line: nil }
  let(:reader) { double :reader }
  let(:manager) { double :manager }
  subject { BitmapEditor.new }

  before do
    allow(OutputWriter).to receive(:new).and_return writer
    allow(InputReader).to receive(:new).and_return reader
    allow(MapManager).to receive(:new).and_return manager
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

    it 'passes build commands on to manager' do
      expect(reader).to receive(:read_line).and_return(%w(I 5 6), ['X'])
      expect(manager).to receive(:create_map).with('5', '6')
      subject.run
    end

    it 'rescues build errors and tells user' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).ordered
      expect(writer).to receive(:write_line).with(OutputStrings::INVALID).ordered
      expect(reader).to receive(:read_line).and_return(%w(I 5 6), ['X'])
      expect(manager).to receive(:create_map).and_raise(ArgumentError)
      subject.run
    end

    it 'shows prints rows on show command' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).ordered
      expect(writer).to receive(:write_line).with('abc').ordered
      expect(writer).to receive(:write_line).with('def').ordered
      expect(reader).to receive(:read_line).and_return(['S'], ['X'])
      expect(manager).to receive(:each_row_as_string).and_yield('abc').and_yield('def')
      subject.run
    end

    it 'passes on edit pixel messages' do
      expect(reader).to receive(:read_line).and_return(%w(L 2 3 A), ['X'])
      expect(manager).to receive(:edit_pixel).with('2', '3', 'A')
      subject.run
    end

    it 'rescues edit errors and tells user' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).ordered
      expect(writer).to receive(:write_line).with(OutputStrings::INVALID).ordered
      expect(reader).to receive(:read_line).and_return(%w(L 2 3 A), ['X'])
      expect(manager).to receive(:edit_pixel).and_raise(ArgumentError)
      subject.run
    end

    it 'passes on horiz messages' do
      expect(reader).to receive(:read_line).and_return(%w(H 2 3 4 A), ['X'])
      expect(manager).to receive(:edit_row).with('2', '3', '4', 'A')
      subject.run
    end

    it 'rescues horiz errors and tells user' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).ordered
      expect(writer).to receive(:write_line).with(OutputStrings::INVALID).ordered
      expect(reader).to receive(:read_line).and_return(%w(H 2 3 A), ['X'])
      expect(manager).to receive(:edit_row).and_raise(ArgumentError)
      subject.run
    end

    it 'passes on vert messages' do
      expect(reader).to receive(:read_line).and_return(%w(V 2 3 4 A), ['X'])
      expect(manager).to receive(:edit_column).with('2', '3', '4', 'A')
      subject.run
    end

    it 'rescues vert errors and tells user' do
      expect(writer).to receive(:write_line).with(OutputStrings::INITIAL_PROMPT).ordered
      expect(writer).to receive(:write_line).with(OutputStrings::INVALID).ordered
      expect(reader).to receive(:read_line).and_return(%w(V 2 3 A), ['X'])
      expect(manager).to receive(:edit_column).and_raise(ArgumentError)
      subject.run
    end

    it 'passes clear commands on to manager' do
      expect(reader).to receive(:read_line).and_return(['C'], ['X'])
      expect(manager).to receive(:clear_map)
      subject.run
    end
  end
end
