require 'spec_helper'
require_relative '../../lib/bitmap_editor/map_manager'

RSpec.describe MapManager do
  subject { MapManager.new }

  describe '#create_map' do
    it 'builds a map of Os of specified dimensions' do
      expect(subject.create_map(2, 3)).to eq [%w(O O), %w(O O), %w(O O)]
    end

    it 'fails on invalid params' do
      expect { subject.create_map('none', 3) }.to raise_error(ArgumentError)
    end

    it 'fails on wrong num of params' do
      expect { subject.create_map(2, 3, 'blue') }.to raise_error(ArgumentError)
    end
  end

  describe '#each_row_as_string' do
    it 'yields each row as a string representation' do
      subject.create_map(2, 3)
      expect { |b| subject.each_row_as_string(&b) }.to yield_successive_args('OO', 'OO', 'OO')
    end
  end

  describe '#edit_pixel' do
    it 'changes a specified pixel to a colour' do
      subject.create_map(2, 3)
      subject.edit_pixel(1, 1, 'A')
      expect { |b| subject.each_row_as_string(&b) }.to yield_successive_args('AO', 'OO', 'OO')
    end

    it 'rejects invalid colours' do
      subject.create_map(2, 3)
      expect { subject.edit_pixel(1, 1, '!') }.to raise_error(ArgumentError)
    end

    it 'rejects invalid coords' do
      subject.create_map(2, 3)
      expect { subject.edit_pixel(0, 1, 'A') }.to raise_error(ArgumentError)
    end
  end

  describe '#edit_row' do
    it 'changes a specified range of pixels to a colour' do
      subject.create_map(3, 3)
      subject.edit_row(2, 3, 2, 'A')
      expect { |b| subject.each_row_as_string(&b) }.to yield_successive_args('OOO', 'OAA', 'OOO')
    end

    it 'rejects invalid colours' do
      subject.create_map(2, 3)
      expect { subject.edit_row(1, 1, 1, '!') }.to raise_error(ArgumentError)
    end

    it 'rejects invalid coords' do
      subject.create_map(3, 3)
      expect { subject.edit_row(1, 4, 1, 'A') }.to raise_error(ArgumentError)
    end
  end

  describe '#edit_column' do
    it 'changes a specified range of pixels to a colour' do
      subject.create_map(3, 3)
      subject.edit_column(2, 2, 3, 'A')
      expect { |b| subject.each_row_as_string(&b) }.to yield_successive_args('OOO', 'OAO', 'OAO')
    end

    it 'rejects invalid colours' do
      subject.create_map(2, 3)
      expect { subject.edit_column(1, 1, 1, '!') }.to raise_error(ArgumentError)
    end

    it 'rejects invalid coords' do
      subject.create_map(3, 3)
      expect { subject.edit_column(1, 4, 1, 'A') }.to raise_error(ArgumentError)
    end
  end

  describe '#clear_map' do
    it 'sets all pixels to O' do
      subject.create_map(3, 3)
      subject.edit_column(2, 2, 3, 'A')
      subject.clear_map
      expect { |b| subject.each_row_as_string(&b) }.to yield_successive_args('OOO', 'OOO', 'OOO')
    end
  end
end
