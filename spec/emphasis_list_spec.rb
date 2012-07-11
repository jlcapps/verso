require 'spec_helper'

describe Verso::EmphasisList do
  before do
    @raw_edition_list = {
      "emphases" => [ { "title" => "Earth Science", "id" => 7 } ]
    }
    Net::HTTP.
      should_receive(:get).
      and_return(JSON.pretty_generate(@raw_edition_list))
    @emphases = Verso::EmphasisList.new
  end

  it 'should respond to #first' do
    @emphases.first.title.should eq("Earth Science")
  end

  it 'should responds to #last' do
    @emphases.last.title.should eq("Earth Science")
  end
end
