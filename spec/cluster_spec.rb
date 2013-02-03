require 'spec_helper'

describe Verso::Cluster, :vcr do

  before(:each) do
    @cluster = Verso::ClusterList.new.first
  end

  describe '#code' do
    it 'responds' do
      @cluster.should respond_to(:code)
    end

    it 'is String' do
      @cluster.code.should be_a(String)
    end

    it 'is formatted like 1, 2, etc.' do
      @cluster.code.should match(/\d+/)
    end
  end

  describe '#contact' do
    it 'responds' do
      @cluster.should respond_to(:contact)
    end

    it 'is an OpenStruct' do
      @cluster.contact.should be_a(OpenStruct)
    end

    it 'has name' do
      @cluster.contact.name.should be_a(String)
    end

    it 'has email' do
      @cluster.contact.email.should match(/\w+@doe.virginia.gov/)
    end

    it 'has phone' do
      @cluster.contact.phone.should match(/\d{3}-\d{3}-\d{4}/)
    end
  end

  describe '#description' do
    it 'responds' do
      @cluster.should respond_to(:description)
    end

    it 'is String' do
      @cluster.description.should be_a(String)
    end

    it 'is HTML' do
      @cluster.description.should match(/<\/.+>/)
    end
  end

  describe '#id' do
    it 'responds' do
      @cluster.should respond_to(:id)
    end

    it 'is Fixnum' do
      @cluster.id.should be_a(Fixnum)
    end

    it 'is not the same as #object_id' do
      @cluster.id.should_not == @cluster.object_id
    end
  end

  describe '#pathways' do
    it 'responds' do
      @cluster.should respond_to(:pathways)
    end

    it 'is Array' do
      @cluster.pathways.should be_a(Array)
    end

    it 'includes a Pathway' do
      @cluster.pathways.first.should be_a(Verso::Pathway)
    end
  end

  describe '#postsecondary_info' do
    it 'responds' do
      @cluster.should respond_to(:postsecondary_info)
    end

    it 'is String' do
      @cluster.postsecondary_info.should be_a(String)
    end

    it 'is HTML' do
      @cluster.postsecondary_info.should match(/<\/.+>/)
    end
  end

  describe '#slug' do
    it 'responds' do
      @cluster.should respond_to(:slug)
    end

    it 'is a string' do
      @cluster.slug.should be_a(String)
    end

    it 'looks like the title' do
      @cluster.slug.should == 'agriculture-food-and-natural-resources'
    end
  end

  describe '#title' do
    it 'responds' do
      @cluster.should respond_to(:title)
    end

    it 'returns String' do
      @cluster.title.should be_a(String)
    end

    it 'returns correct title' do
      @cluster.title.should == 'Agriculture, Food and Natural Resources'
    end
  end

  describe '#http_get' do
    before do
      @bad_cluster = Verso::Cluster.new(:id => 9999999999999999)
    end

    it 'raises ResourceNotFoundError when resource not found' do
      expect { @bad_cluster.description }.to raise_error(
        Verso::ResourceNotFoundError
      )
    end
  end
end
