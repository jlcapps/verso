require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::CredentialList do
  use_vcr_cassette :record => :new_episodes
  describe 'array-like behavior' do
    before(:each) do
      @list = Verso::CredentialList.new
      @kontained = Verso::Credential
    end

    it_behaves_like 'any Verso list'

  end

  describe 'search' do
    before(:each) do
      @list = Verso::CredentialList.new(:text => 'nocti')
    end

    it 'is a collection of Verso::Credential objects' do
      @list.first.should be_a(Verso::Credential)
    end

    it 'is related to the search term' do
      @list.first.source.title.should match (/NOCTI/)
    end
  end

  describe 'empty search' do
    it 'gives you everything' do
      Verso::CredentialList.new(:text => '').count.should eq(
        Verso::CredentialList.new.count
      )
    end
  end
end
