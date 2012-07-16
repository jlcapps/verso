require 'spec_helper'

describe Verso::Standard do
  before do
    @goal = { "title" => "goal title",
              "description" => "goal description" }
    @nested_goal = { "title" => "nested goal title",
                     "description" => "nested goal description" }
    @section = { "title" => "section title",
                 "description" => "section description",
                 "goals" => [@nested_goal], "sections" => [] }
    @raw_standard =  { :aname => { "title" => "standard title",
                                   "description" => "standard description",
                                   "goals" => [@goal],
                                   "sections" => [@section] } }
    @standard = Verso::Standard.new(@raw_standard.values.first)
  end

  it "should respond to title" do
    @standard.title.should eq("standard title")
  end

  it "should respond to description" do
    @standard.description.should eq("standard description")
  end

  it "should respond to sections" do
    @standard.sections.first.title.should eq("section title")
  end

  it "should respond to goals" do
    @standard.goals.first.title.should eq("goal title")
  end

  it "should respond to nested goals" do
    @standard.sections.first.goals.first.title.should eq("nested goal title")
  end

  it "should fetch standard as necessary" do
    course = OpenStruct.new(:code => "6320", :edition => "2011")
    std = { "name" => "science" }
    std = Verso::Standard.new(std, course)
    std.name.should eq("science")
    std.code.should eq("6320")

    raw_std = { "standard" => { "title" => "Science", "sections" => [],
                                "goals" => [] } }
    Net::HTTP.stub(:get).and_return(nil)
    JSON.stub(:parse).and_return(raw_std)
    std.title.should eq("Science")
    std.name.should eq("science")
  end
end
