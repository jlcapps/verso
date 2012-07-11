require 'spec_helper'

describe Verso::SOLCorrelationList do
  before do
    @goal = OpenStruct.new({ "title" => "goal title",
                             "description" => "goal description" })
    @standard = double("Standard", :title => "standard title",
                       :description => "standard description",
                       :goals => [@goal], :sections => [])
    @standards_list = [@standard]
    @standards_list.stub(:sols).
      and_return([OpenStruct.new(:name => "english"),
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
         "english" => { "title" => "English", "description" => "",
                        "sections" => [],
                        "goals" => [
                          { "title" => "english goal title",
                            "description" => "english goal description" }
                        ] }
       }
      }
    ]}.to_json
    correlations2 = { "correlations" => [
      {"id" => "111", "statement" => "task statement",
       "goals" => {
         "science" => { "title" => "Science", "description" => "",
                        "sections" => [],
                        "goals" => [
                          { "title" => "science goal title",
                            "description" => "science goal description" }
                        ] }
       }
      }
    ]}.to_json
    @correlations = Verso::SOLCorrelationList.new(@course)
    Net::HTTP.should_receive(:get).
      with('api.cteresource.org',
           "/courses/#{@course.code},#{@course.edition}/standards/english/correlations",
           80).
      and_return(correlations1)
    Net::HTTP.should_receive(:get).
      with('api.cteresource.org',
           "/courses/#{@course.code},#{@course.edition}/standards/science/correlations",
           80).
      and_return(correlations2)
  end

  it 'is enumerable' do
    @correlations.first.statement.should eq('task statement')
  end

  it 'numbers the correlations' do
    @correlations.first.number.should eq(1)
  end

  it 'compiles the goals' do
    @correlations.first.standards.count.should eq(2)
    titles = @correlations.first.standards.collect { |s| s.title }
    titles.first.should eq('English')
    titles.last.should eq('Science')
  end
end
