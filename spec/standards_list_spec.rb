require 'spec_helper'

describe Verso::StandardsList do
  before do
    @goal = OpenStruct.new({ "title" => "goal title",
                             "description" => "goal description" })
    @nested_goal = OpenStruct.new(
      { "title" => "nested goal title",
        "description" => "nested goal description" }
    )
    @section = OpenStruct.new(
      { "title" => "section title", "description" => "section description",
        "goals" => [@nested_goal], "sections" => [] }
    )
    @raw_standard =  { :aname => { "title" => "standard title",
                                   "description" => "standard description",
                                   "goals" => [@goal],
                                   "sections" => [@section] } }
    sol =  { :science => { "title" => "Science",
                           "description" => "standard description",
                           "name" => "science",
                           "goals" => [@goal],
                           "sections" => [@section] } }
    @raw_standard.merge!(sol)
    @standards_list = Verso::StandardsList.new(@raw_standard)
  end

  it "responds as Enumerable" do
    @standards_list.last.title.should eq("standard title")
    @standards_list.first.title.should eq("Science")
  end

  it "should respond to sols" do
    @standards_list.sols.first.title.should eq('Science')
  end

  it "should respond to non_sols" do
    @standards_list.non_sols.first.title.should eq("standard title")
  end

  it "should create a list from a course" do
    course = double("Course", :code => "6320", :edition => "2011")
    Net::HTTP.stub(:get).and_return(nil)
    raw = { "standards" => @raw_standard.values }
    JSON.stub(:parse).and_return(raw)
    sl = Verso::StandardsList.new(raw["standards"], course)
    Verso::StandardsList.should_receive(:new).with(raw["standards"], course).
      and_return(sl)
    Verso::StandardsList.from_course(course).last.title.should eq("standard title")
  end
end
