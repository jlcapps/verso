require 'spec_helper'

describe Verso::OccupationData do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @od = Verso::OccupationList.new(:text => "golf").first
  end
  describe '#cluster' do
    it 'responds' do
      @od.should respond_to(:cluster)
    end

    it 'is a Verso::Cluster' do
      @od.cluster.should be_a(Verso::Cluster)
    end
  end

  describe '#pathway' do
    it 'responds' do
      @od.should respond_to(:pathway)
    end

    it 'is a Verso::Pathway' do
      @od.pathway.should be_a(Verso::Pathway)
    end
  end

  describe '#occupations' do
    it 'responds' do
      @od.should respond_to(:occupations)
    end

    it 'is an Array' do
      @od.occupations.should be_a(Array)
    end

    it 'is an Array of Verso::Occupation objects' do
      @od.occupations.first.should be_a(Verso::Occupation)
    end
  end
end
