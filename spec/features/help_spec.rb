require 'spec_helper'

RSpec.describe 'Need help' do
  before { stub_nonfunctional_output }

  it 'shows me help if I ask for it' do
    expect(STDIN).to receive(:gets).and_return '?', 'X'
    expect(STDOUT).to receive(:puts) do |output|
      expect(output).to start_with('? - Help')
    end.ordered
    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end

  it 'corrects me if I enter an invalid command' do
    expect(STDIN).to receive(:gets).and_return 'Z', 'X'
    expect(STDOUT).to receive(:puts).with('unrecognised command :(').ordered
    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end
end
