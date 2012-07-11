require 'spec_helper'

describe Verso::CourseList do
  use_vcr_cassette :record => :new_episodes

  it "searches by text" do
    results = Verso::CourseList.new(:text => "6321")
    results.first.title.strip.should eq("Accounting, Advanced")
  end

  it "should return no results when query is empty" do
    results = Verso::CourseList.new(:text => nil)
    results.count.should == 0
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

  it "should return empty results when query is empty" do
    Verso::CourseList.new({}).count.should == 0
    [:text, :program_area, :cluster].each do |k|
      Verso::CourseList.new(k => nil).count.should == 0
      Verso::CourseList.new(k => '').count.should == 0
    end
    Verso::CourseList.new(:text => '', :program_area => '', :cluster => '').
      count.should == 0
  end
end
