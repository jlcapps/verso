require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::OccupationList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::OccupationList.new(:text => "teacher")
    @kontained = Verso::OccupationData
  end

  it_behaves_like 'any Verso list'

  it 'returns an empty array if the search is empty' do
    Verso::OccupationList.new.should be_empty
  end

  it "searches by text" do
    results = Verso::OccupationList.new(:text => "golf")
    results.first.occupations.first.title.should match(/Turf/)
  end
end
