require 'spec_helper'

describe Verso::ProgramArea do
  before do
    @pa = Verso::ProgramArea.new("title" => "Career Connections")
  end

  it 'should respond to description' do
    @pa.description.should eq("")
  end

  it 'should respond to title' do
    @pa.title.should eq("Career Connections")
  end

  it 'should respond to slug' do
    @pa.slug.should eq('career-connections')
  end

  it 'should respond to courses' do
    @course = double("Course", :title => "a course", :edition => "1998",
                     :code => "9999")
    Verso::CourseList.should_receive(:new).
      with(:program_area => "career connections").
      and_return([@course])
    @pa.courses.should eq([@course])
  end

  it 'should respond to deprecated' do
    @pa.stub(:http_get).
      and_return(
        { "program_areas" => [ {
            "title" => "Career Connections",
            "deprecated" => false
          } ] }.to_json
      )
    @pa.deprecated.should eq(false)
  end
end
