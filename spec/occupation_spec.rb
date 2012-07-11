require 'spec_helper'

describe Verso::Occupation do
  before do
    @raw_occupation = { "id" => 2966,
                        "title" => "Agricultural Commodity Broker",
                        "pathway" => { "title" => "Agriculture" } }
    @occupation = Verso::Occupation.new(@raw_occupation)
  end

  it 'should respond to #title' do
    @occupation.title.should eq("Agricultural Commodity Broker")
  end

  it 'should respond to #id' do
    @occupation.id.should eq(2966)
  end

  it 'should respond to #pathway' do
    @occupation.pathway.title.should eq("Agriculture")
  end

  it 'should respond to #related_courses' do
    Net::HTTP.
      should_receive(:get).
      with('api.cteresource.org', "/occupations/2966", 80).
      and_return(
        JSON.pretty_generate(
          :occupation => {
            :id => 2966,
            :title => "Agricultural Commodity Broker",
            :related_courses => [
              { :code => "8050",
                :title => "Agricultural Education--Preparation" }
            ]
          }
        )
      )
      @occupation.related_courses.first.code.should eq("8050")
  end
end
