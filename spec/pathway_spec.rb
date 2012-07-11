require 'spec_helper'

describe Verso::Pathway do
  before do
    @raw_cluster = { "title" => "Agriculture, Food, and Natural Resources",
                     "id" => 49 }
    @raw_pathway = { "title" => "Agribusiness Systems", "id" => 306 ,
                     "cluster" => @raw_cluster }
    @pathway = Verso::Pathway.new(@raw_pathway)
  end

  it 'should respond to #title' do
    @pathway.title.should eq('Agribusiness Systems')
  end

  it 'should respond to #cluster' do
    @pathway.cluster.id.should eq(49)
  end

  it 'should respond to #id' do
    @pathway.id.should eq(306)
  end

  it 'should respond to #occupations' do
    Net::HTTP.
      should_receive(:get).
      with('api.cteresource.org', "/pathways/306", 80).
      and_return(
        JSON.pretty_generate(
          :pathway => {
            :id => 306,
            :title => "Agribusiness Systems",
            :occupations => [
              { :id => 2966, :title => "Agricultural Commodity Broker" }
            ]
          }
        )
      )
    @pathway.occupations.first.title.should eq('Agricultural Commodity Broker')
  end
end
