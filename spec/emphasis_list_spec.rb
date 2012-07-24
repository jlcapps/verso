require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::EmphasisList do
  use_vcr_cassette :record => :new_episodes

  before do
    @list = Verso::EmphasisList.new
    @kontained = Verso::Emphasis
  end

  it_behaves_like 'any Verso list'
end
