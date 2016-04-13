require 'spec_helper'

RSpec.describe 'Feature: Edit image' do
  before { stub_nonfunctional_output }

  it 'lets me change a pixel colour' do
    expect(STDIN).to receive(:gets).and_return 'I 3 3', 'L 3 2 A', 'S', 'X'

    expect(STDOUT).to receive(:puts).with('OOO').ordered
    expect(STDOUT).to receive(:puts).with('OOA').ordered
    expect(STDOUT).to receive(:puts).with('OOO').ordered

    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end
end
