require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::EmphasisList, :vcr do

  before do
    @list = Verso::EmphasisList.new
    @kontained = Verso::Emphasis
  end

  it_behaves_like 'any Verso list'
end
