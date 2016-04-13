require 'spec_helper'

RSpec.describe 'Feature: Create image' do
  before { stub_nonfunctional_output }

  it 'shows me an image I define' do
    expect(STDIN).to receive(:gets).and_return 'I 3 5', 'S', 'X'
    expect(STDOUT).to receive(:puts).with('OOO').exactly(5).times.ordered
    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end
end
