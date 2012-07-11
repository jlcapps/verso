require 'spec_helper'

describe Verso::OccupationList do
  it "searches by text" do
    Net::HTTP.should_receive(:get).
      with('api.cteresource.org', '/occupations?text=teacher', 80).
      and_return(
        JSON.pretty_generate(
          { :occupation_data => [{
              :cluster => { :title => "Education and Training" },
              :pathway => { :title => "Teaching and Training" },
              :occupations => [
                { :title => "Elementary School Teacher" }
              ]
            }] }
         )
      )
    results = Verso::OccupationList.new(:text => "teacher")
    results.first.occupations.first.title.should eq("Elementary School Teacher")
  end
end
