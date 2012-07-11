require 'spec_helper'

describe Verso::OccupationData do
  before do
    @occupation_data = [{
    "cluster" => { "title" => "Information Technology" },
    "pathway" => { "title" => "Information and Support Services" },
    "occupations" => [{ "title" => "Database Analyst" }]
    }]
    @occdata = Verso::OccupationData.new(@occupation_data.first)
  end

  it 'should respond to title' do
    @occdata.cluster.title.should eq("Information Technology")
  end

  it 'should respond to pathway' do
    @occdata.pathway.title.should eq("Information and Support Services")
  end

  it 'should respond to occupations' do
    @occdata.occupations.first.title.should eq("Database Analyst")
  end
end
