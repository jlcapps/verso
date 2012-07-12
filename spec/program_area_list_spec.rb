require 'spec_helper'

describe Verso::ProgramAreaList do
  use_vcr_cassette :record => :new_episodes

  it 'responds to #first, #last' do
    list = Verso::ProgramAreaList.new
    list.first.title.should eq("Academic")
    list.last.title.should eq("Trade and Industrial Education")
  end
end
