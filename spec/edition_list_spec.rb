require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::EditionList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::EditionList.new
    @kontained = OpenStruct
  end

  it_behaves_like 'any Verso list'

  describe 'OpenStruct edition proxy' do
    describe '#year' do
      it 'responds' do
        @list.last.should respond_to(:year)
      end

      it 'looks like a year' do
        @list.first.year.should match(/2\d{3}/)
      end
    end
  end
end
