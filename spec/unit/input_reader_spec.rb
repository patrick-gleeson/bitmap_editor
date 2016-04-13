require 'spec_helper'
require_relative '../../lib/bitmap_editor/input_reader'

RSpec.describe InputReader do
  let(:input) { double :input }
  subject { InputReader.new(input) }

  let(:content) { 'Somestring' }

  describe '#read_line' do
    it 'returns content from gets function' do
      expect(input).to receive(:gets).and_return(content)
      expect(subject.read_line).to eq [content]
    end

    it 'removes trailing newlines' do
      expect(input).to receive(:gets).and_return(content + "\n")
      expect(subject.read_line).to eq [content]
    end

    it 'splits on spaces' do
      expect(input).to receive(:gets).and_return(content + " other")
      expect(subject.read_line).to eq [content, "other"]
    end
  end
end
