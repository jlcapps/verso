require 'spec_helper'

describe Verso::ExtrasList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @extras = Verso::ExtrasList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year
    )
  end

  describe 'array-like behavior' do
    describe '#[]' do
      it 'responds' do
        @extras.should respond_to(:[])
      end

      it 'gets a Verso::Extra object' do
        @extras[1].should be_a(Verso::Extra)
      end
    end

    describe '#each' do
      it 'responds' do
        @extras.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @extras.each("foo", &b).to yield_control }
      end

      it 'yields Verso::Extra objects' do
        @extras.each { |c| c.should be_a(Verso::Extra) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @extras.should respond_to(:empty?)
      end

      it 'is not empty' do
        @extras.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @extras.should respond_to(:last)
      end

      it 'is a Verso::Extra object' do
        @extras.last.should be_a(Verso::Extra)
      end
    end

    describe '#length' do
      it 'responds' do
        @extras.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @extras.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @extras.should respond_to(:first)
      end

      it 'is a Verso::Extra object' do
        @extras.first.should be_a(Verso::Extra)
      end
    end

    describe '#count' do
      it 'responds' do
        @extras.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @extras.count.should be_a(Fixnum)
      end
    end
  end
end
