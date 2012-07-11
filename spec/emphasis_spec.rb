require 'spec_helper'

describe Verso::Emphasis do
  before do
    @emphasis = Verso::Emphasis.new("id" => 7, "title" => "Earth Science")
  end

  it 'responds to #title' do
    @emphasis.title.should eq("Earth Science")
  end

  it 'responds to #occupation_data' do
    occupation_data = [{
      "cluster" => { "title" => "Information Technology", "id" => 1 },
      "pathway" => { "title" => "Information and Support Services", "id" => 2 },
      "occupations" => [{ "title" => "Database Analyst", "id" => 3 }]
    }]
    Net::HTTP.should_receive(:get).
      with('api.cteresource.org', "/academics/7", 80).
      and_return(
        JSON.pretty_generate(
          :emphasis => {
            :id => 7, :title => "Earth Science",
            :occupation_data => occupation_data }
        )
      )
    @emphasis.occupation_data.first.cluster.title.should eq(
      "Information Technology"
    )
  end
end
