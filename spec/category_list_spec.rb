require 'spec_helper'

describe Verso::CategoryList do
  use_vcr_cassette :record => :new_episodes

  it "responds to #first, #last" do
    list = Verso::CategoryList.new
    list.first.title.strip.should eq("Across the Board")
    list.last.title.strip.
      should eq("Transportation, Distribution and Logistics")
  end
end
