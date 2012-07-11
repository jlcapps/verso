require 'spec_helper'

describe Verso::EditionList do
  use_vcr_cassette :record => :new_episodes

  it "responds to #first, #last" do
    list = Verso::EditionList.new
    list.first.year.should match(/20\d\d/)
    list.last.year.should match(/20\d\d/)
  end
end
