require 'spec_helper'

describe Verso::ClusterList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::ClusterList.new
  end

  describe '#[]' do
    it 'responds' do
      @list.should respond_to(:[])
    end

    it 'is a Verso::Cluster object' do
      @list[3].should be_a(Verso::Cluster)
    end
  end

  describe '#each' do
    it 'responds' do
      @list.should respond_to(:each)
    end

    it 'yields' do
      expect { |b| @list.each("foo", &b).to yield_control }
    end

    it 'yields Verso::Cluster objects' do
      @list.each do |c|
        c.should be_a(Verso::Cluster)
      end
    end
  end

  describe '#empty?' do
    it 'responds' do
      @list.should respond_to(:empty?)
    end

    it 'is not empty' do
      @list.should_not be_empty
    end
  end

  describe '#last' do
    it 'responds' do
      @list.should respond_to(:last)
    end

    it 'is a Verso::Cluster object' do
      @list.last.should be_a(Verso::Cluster)
    end
  end

  describe '#length' do
    it 'responds' do
      @list.should respond_to(:length)
    end

    it 'is 16' do
      @list.length.should == 16
    end
  end

  describe '#first' do
    it 'responds' do
      @list.should respond_to(:first)
    end

    it 'is a Verso::Cluster object' do
      @list.first.should be_a(Verso::Cluster)
    end
  end

  describe '#count' do
    it 'responds' do
      @list.should respond_to(:count)
    end

    it 'is 16' do
      @list.count.should == 16
    end
  end
end
