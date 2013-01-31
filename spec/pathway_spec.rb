require 'spec_helper'

describe Verso::Pathway do
  use_vcr_cassette :record => :new_episodes

  before do
    @pathway = Verso::ClusterList.new.first.pathways.first
  end

  describe '#cluster' do
    it 'responds' do
      @pathway.should respond_to(:cluster)
    end

    it 'is a Verso::Cluster' do
      @pathway.cluster.should be_a(Verso::Cluster)
    end
  end

  describe '#description' do
    it 'responds' do
      @pathway.should respond_to(:description)
    end

    it 'is a String' do
      @pathway.description.should be_a(String)
    end

    it 'is HTML' do
      @pathway.description.should match(/<\/.+>/)
    end
  end

  describe '#id' do
    it 'responds' do
      @pathway.should respond_to(:id)
    end

    it 'is a Fixnum' do
      @pathway.id.should be_a(Fixnum)
    end

    it 'is not the same as #object_id' do
      @pathway.id.should_not == @pathway.object_id
    end
  end

  describe '#slug' do
    it 'responds' do
      @pathway.should respond_to(:slug)
    end

    it 'is a string' do
      @pathway.slug.should be_a(String)
    end

    it 'looks like the title' do
      @pathway.slug.should == 'agribusiness-systems'
    end
  end

  describe '#occupations' do
    it 'responds' do
      @pathway.should respond_to(:occupations)
    end

    it 'is an Array' do
      @pathway.occupations.should be_a(Array)
    end

    it 'is an Array containing Verso::Occupation objects' do
      @pathway.occupations.first.should be_a(Verso::Occupation)
    end
  end
end
