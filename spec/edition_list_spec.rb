require 'spec_helper'

describe Verso::EditionList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @editions = Verso::EditionList.new
  end

  describe 'array-like behavior' do
    describe '#[]' do
      it 'responds' do
        @editions.should respond_to(:[])
      end

      it 'gets a OpenStruct object' do
        @editions[0].should be_a(OpenStruct)
      end
    end

    describe '#each' do
      it 'responds' do
        @editions.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @editions.each("foo", &b).to yield_control }
      end

      it 'yields OpenStruct objects' do
        @editions.each { |c| c.should be_a(OpenStruct) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @editions.should respond_to(:empty?)
      end

      it 'is not empty' do
        @editions.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @editions.should respond_to(:last)
      end

      it 'is a OpenStruct object' do
        @editions.last.should be_a(OpenStruct)
      end
    end

    describe '#length' do
      it 'responds' do
        @editions.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @editions.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @editions.should respond_to(:first)
      end

      it 'is a OpenStruct object' do
        @editions.first.should be_a(OpenStruct)
      end
    end

    describe '#count' do
      it 'responds' do
        @editions.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @editions.count.should be_a(Fixnum)
      end
    end
  end

  describe 'OpenStruct edition proxy' do
    describe '#year' do
      it 'responds' do
        @editions.last.should respond_to(:year)
      end

      it 'looks like a year' do
        @editions.first.year.should match(/2\d{3}/)
      end
    end
  end
end
