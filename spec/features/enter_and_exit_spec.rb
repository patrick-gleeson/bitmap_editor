require 'spec_helper'

RSpec.describe 'Feature: Enter and exit the program' do
  before { stub_nonfunctional_output }

  it 'lets me exit straight away' do
    expect(STDIN).to receive(:gets).and_return 'X'
    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end
end
