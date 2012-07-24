require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::CorrelationList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::CorrelationList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year,
      :name => "english"
    )
    @kontained = Verso::Task
  end

  describe '#code' do
    it { @list.code.should == '6320' }
  end

  describe '#edition' do
    it { @list.edition.should match(/2\d{3}/) }
  end

  describe '#name' do
    it { @list.name.should == 'english' }
  end

  describe '#title' do
    it { @list.title.should == 'English' }
  end

  it_behaves_like 'any Verso list'
end
