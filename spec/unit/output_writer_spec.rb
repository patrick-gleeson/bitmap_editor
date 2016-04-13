require 'spec_helper'
require_relative '../../lib/bitmap_editor/output_writer'

RSpec.describe OutputWriter do
  let(:output) { double :output }
  subject { OutputWriter.new(output) }

  let(:content) { 'Some string' }

  describe '#write' do
    it 'passes content on to print function' do
      expect(output).to receive(:print).with(content)
      subject.write(content)
    end
  end

  describe '#write_line' do
    it 'passes content on to puts function' do
      expect(output).to receive(:puts).with(content)
      subject.write_line(content)
    end
  end
end
