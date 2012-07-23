require 'spec_helper'

describe Verso::StandardsList do
  use_vcr_cassette :record => :new_episodes

  before do
    @list = Verso::StandardsList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year
    )
  end

  describe 'array-like behavior' do
    describe '#[]' do
      it 'responds' do
        @list.should respond_to(:[])
      end

      it 'gets a Verso::Standard object' do
        @list[2].should be_a(Verso::Standard)
      end
    end

    describe '#each' do
      it 'responds' do
        @list.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @list.each("foo", &b).to yield_control }
      end

      it 'yields Verso::Standard objects' do
        @list.each { |c| c.should be_a(Verso::Standard) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @list.should respond_to(:empty?)
      end

      it 'is not empty' do
        @list.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @list.should respond_to(:last)
      end

      it 'is a Verso::Standard object' do
        @list.last.should be_a(Verso::Standard)
      end
    end

    describe '#length' do
      it 'responds' do
        @list.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @list.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @list.should respond_to(:first)
      end

      it 'is a Verso::Standard object' do
        @list.first.should be_a(Verso::Standard)
      end
    end

    describe '#count' do
      it 'responds' do
        @list.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @list.count.should be_a(Fixnum)
      end
    end
  end

  describe '#non_sols' do
    it 'responds' do
      @list.should respond_to(:non_sols)
    end

    it 'is an Array' do
      @list.non_sols.should be_a(Array)
    end

    it 'is an Array of Verso::Standard Objects' do
      @list.non_sols.first.should be_a(Verso::Standard)
    end

    it 'does not include SOLs like English' do
      @list.non_sols.any? { |s| s.title == 'English'}.should be_false
    end
  end

  describe '#sols' do
    it 'responds' do
      @list.should respond_to(:sols)
    end

    it 'is an Array' do
      @list.sols.should be_a(Array)
    end

    it 'is an Array of Verso::Standard Objects' do
      @list.sols.first.should be_a(Verso::Standard)
    end

    it 'includes SOLs like English' do
      @list.sols.any? { |s| s.title == 'English' }.should be_true
    end
  end

  describe 'self.from_course' do
    before do
      @course = Verso::CourseList.new(:code => "6320").last
    end

    it 'responds' do
      Verso::StandardsList.should respond_to(:from_course)
    end

    it 'returns a Verso::StandardsList' do
      Verso::StandardsList.from_course(@course).
        should be_a(Verso::StandardsList)
    end

    it 'has the correct code and edition' do
      list = Verso::StandardsList.from_course(@course)
      list.code.should == @course.code
      list.edition.should == @course.edition
    end
  end
end
