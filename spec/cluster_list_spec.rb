require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::ClusterList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::ClusterList.new
    @kontained = Verso::Cluster
  end

  it_behaves_like "any Verso list"
end
