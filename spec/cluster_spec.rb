require 'spec_helper'

describe Verso::Cluster do
  before do
    @pathway = { "title" => "Agribusiness Systems", "id" => 306 }
    @raw_cluster = { "title" => "Information Technology",
                     "pathways" => [@pathway] }
    @cluster = Verso::Cluster.new(@raw_cluster)
  end

  it 'should respond to title' do
    @cluster.title.should eq("Information Technology")
  end

  it 'should respond to pathways' do
    @cluster.pathways.first.title.should eq("Agribusiness Systems")
  end
end
