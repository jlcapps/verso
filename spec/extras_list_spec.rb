require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::ExtrasList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::ExtrasList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year
    )
    @kontained = Verso::Extra
  end

  it_behaves_like "any Verso list"
end
