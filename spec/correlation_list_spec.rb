require 'spec_helper'

describe Verso::CorrelationList do
  before do
    @goal = OpenStruct.new({ "title" => "goal title",
                             "description" => "goal description" })
    @standard = double("Standard", :title => "standard title",
                       :name => "standard_name",
                       :description => "standard description",
                       :goals => [@goal], :sections => [])
    @standards_list = [@standard]
    @standards_list.stub(:non_sols).
      and_return([OpenStruct.new(:name => "standard_name"),
                  OpenStruct.new(:name => "science")])
    @task = double("Task", :statement => "task statement", :id => "111",
                   :standards => @standards_list)
    @tasks = [@task]
    @duty_areas = [OpenStruct.new(:tasks => @tasks)]
    @course = double("Course", :title => "course title", :edition => "1929",
                     :code => "0000", :duration => 36, :hours => nil,
                     :co_op => true, :related_resources => ["tasks"],
                     :standards => @standards_list,
                     :duty_areas => @duty_areas, :certifications => [])
    correlations1 = { "correlations" => [
      {"id" => "111", "statement" => "task statement",
       "goals" => {
         "standard_name" => { "title" => "English", "description" => "",
                              "sections" => [],
                              "goals" => [
                                { "title" => "english goal title",
                                  "description" => "english goal description" }
                        ] }
       }
      }
    ]}.to_json
    @correlations = Verso::CorrelationList.new(@course, "standard_name")
    Net::HTTP.stub(:get).and_return(correlations1)
  end

  it 'is enumerable' do
    @correlations.first.statement.should eq('task statement')
  end

  it 'numbers the correlations' do
    @correlations.first.number.should eq(1)
  end

  it 'has a goal' do
    @correlations.first.standards.count.should_not eq(0)
  end

  it 'responds to #title' do
    @correlations.title.should eq("standard title")
  end
end
