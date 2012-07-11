require 'spec_helper'

describe Verso::ClusterList do
  use_vcr_cassette :record => :new_episodes

  it "responds to #first, #last" do
    list = Verso::ClusterList.new
    list.first.title.strip.should eq("Agriculture, Food and Natural Resources")
    list.last.title.strip.
      should eq("Transportation, Distribution and Logistics")
  end
end
