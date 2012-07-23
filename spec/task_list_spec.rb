require 'spec_helper'

describe Verso::TaskList do
  use_vcr_cassette :record => :new_episodes

  before do
    @tl = Verso::TaskList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year)
  end

  describe '#code' do
    it 'responds' do
      @tl.should respond_to(:code)
    end

    it 'is a String' do
      @tl.code.should be_a(String)
    end
  end

  describe '#edition' do
    it 'responds' do
      @tl.should respond_to(:edition)
    end

    it 'is a String' do
      @tl.edition.should be_a(String)
    end
  end

  describe 'array-like behavior' do
    describe '#[]' do
      it 'responds' do
        @tl.should respond_to(:[])
      end

      it 'gets a Verso::DutyArea object' do
        @tl[10].should be_a(Verso::DutyArea)
      end
    end

    describe '#each' do
      it 'responds' do
        @tl.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @tl.each("foo", &b).to yield_control }
      end

      it 'yields Verso::DutyArea objects' do
        @tl.each { |c| c.should be_a(Verso::DutyArea) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @tl.should respond_to(:empty?)
      end

      it 'is not empty' do
        @tl.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @tl.should respond_to(:last)
      end

      it 'is a Verso::DutyArea object' do
        @tl.last.should be_a(Verso::DutyArea)
      end
    end

    describe '#length' do
      it 'responds' do
        @tl.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @tl.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @tl.should respond_to(:first)
      end

      it 'is a Verso::DutyArea object' do
        @tl.first.should be_a(Verso::DutyArea)
      end
    end

    describe '#count' do
      it 'responds' do
        @tl.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @tl.count.should be_a(Fixnum)
      end
    end
  end

  it "is empty if no task list is published" do
    @tl = Verso::TaskList.new(:code => "1234", :edition => "1929")
    @tl.should be_empty
  end
end
