require 'spec_helper'

RSpec.describe 'Feature: Edit image' do
  before { stub_nonfunctional_output }

  it 'lets me change a pixel colour' do
    expect(STDIN).to receive(:gets).and_return 'I 3 3', 'L 3 2 A', 'S', 'X'

    expect_grid_output(%w(
                         OOO
                         OOA
                         OOO))

    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end

  it 'lets me change a pixel row' do
    expect(STDIN).to receive(:gets).and_return 'I 5 6', 'H 3 5 2 Z', 'S', 'X'

    expect_grid_output(%w(
                         OOOOO
                         OOZZZ
                         OOOOO
                         OOOOO
                         OOOOO
                         OOOOO))

    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end

  it 'lets me change a pixel column' do
    expect(STDIN).to receive(:gets).and_return 'I 5 6', 'V 2 3 6 W', 'S', 'X'

    expect_grid_output(%w(
                         OOOOO
                         OOOOO
                         OWOOO
                         OWOOO
                         OWOOO
                         OWOOO))

    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end

  it 'lets me clear the map' do
    expect(STDIN).to receive(:gets).and_return 'I 5 6', 'V 2 3 6 W', 'C', 'S', 'X'

    expect_grid_output(%w(
                         OOOOO
                         OOOOO
                         OOOOO
                         OOOOO
                         OOOOO
                         OOOOO))

    expect(STDOUT).to receive(:puts).with('goodbye!').ordered

    BitmapEditor.new.run
  end
end
