require 'spec_helper'
require 'shared_verso_list_examples'

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
      @list = Verso::CourseList.new(:cluster => "Information Technology")
      @kontained = Verso::Course
    end

    it_behaves_like "any Verso list"
  end
end
