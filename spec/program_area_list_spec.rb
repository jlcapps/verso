require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::ProgramAreaList do
  use_vcr_cassette :record => :new_episodes

  before do
    @list = Verso::ProgramAreaList.new
    @kontained = Verso::ProgramArea
  end

  it_behaves_like 'any Verso list'
end
