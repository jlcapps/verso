require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::ClusterList, :vcr do

  before(:each) do
    @list = Verso::ClusterList.new
    @kontained = Verso::Cluster
  end

  it_behaves_like "any Verso list"
end
