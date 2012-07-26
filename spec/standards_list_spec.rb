require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::StandardsList do
  use_vcr_cassette :record => :new_episodes

  before do
    @list = Verso::StandardsList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year
    )
    @kontained = Verso::Standard
  end

  it_behaves_like 'any Verso list'

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

    it 'returns an empty list if the course has no standards' do
      course = Verso::Course.new(:code => "1234", :edition => "1929",
                                 :related_resources => [])
      Verso::StandardsList.from_course(course).should be_empty
    end
  end
end
