require 'spec_helper'

describe Verso::CourseList do
  use_vcr_cassette :record => :new_episodes

  describe 'searches' do
    it "searches by code" do
      results = Verso::CourseList.new(:code => "6320")
      results.each { |c| c.code.should == "6320" }
    end

    it "searches by edition" do
      year = Verso::EditionList.new.first.year
      results = Verso::CourseList.new(:edition => year)
      results.first.edition.should == year
      results.last.edition.should == year
    end

    it "searches by text" do
      results = Verso::CourseList.new(:text => "6321")
      results.first.title.strip.should eq("Accounting, Advanced")
    end

    it "searches by cluster" do
      results = Verso::CourseList.new(:cluster => "education and training")
      results.first.title.strip.
        should eq("Equine Management Production")
    end

    it "can find courses by program area too" do
      results = Verso::CourseList.new(:program_area => "across the board")
      results.first.title.strip.should eq("Work-Based Learning through Service")
    end

    it "should return empty results when queries are empty" do
      Verso::CourseList.new({}).count.should == 0
      [:text, :program_area, :cluster].each do |k|
        Verso::CourseList.new(k => nil).count.should == 0
        Verso::CourseList.new(k => '').count.should == 0
      end
      Verso::CourseList.new(:text => '', :program_area => '', :cluster => '').
        count.should == 0
    end
  end

  describe 'array-like behavior' do
    before(:each) do
      @courses = Verso::CourseList.new(:cluster => "Information Technology")
    end

    describe '#[]' do
      it 'responds' do
        @courses.should respond_to(:[])
      end

      it 'gets a Verso::Course object' do
        @courses[10].should be_a(Verso::Course)
      end
    end

    describe '#each' do
      it 'responds' do
        @courses.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @courses.each("foo", &b).to yield_control }
      end

      it 'yields Verso::Course objects' do
        @courses.each { |c| c.should be_a(Verso::Course) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @courses.should respond_to(:empty?)
      end

      it 'is not empty' do
        @courses.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @courses.should respond_to(:last)
      end

      it 'is a Verso::Course object' do
        @courses.last.should be_a(Verso::Course)
      end
    end

    describe '#length' do
      it 'responds' do
        @courses.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @courses.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @courses.should respond_to(:first)
      end

      it 'is a Verso::Course object' do
        @courses.first.should be_a(Verso::Course)
      end
    end

    describe '#count' do
      it 'responds' do
        @courses.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @courses.count.should be_a(Fixnum)
      end
    end
  end
end
