require 'spec_helper'

describe Verso::Emphasis do
  use_vcr_cassette :record => :new_episodes

  before do
    @emphasis = Verso::EmphasisList.new.last
  end

  describe '#title' do
    it 'responds' do
      @emphasis.should respond_to(:title)
    end

    it 'is a string' do
      @emphasis.title.should be_a(String)
    end
  end

  describe '#id' do
    it 'responds' do
      @emphasis.should respond_to(:id)
    end

    it 'is a Fixnum' do
      @emphasis.id.should be_a(Fixnum)
    end

    it 'is not the same as #object_id' do
      @emphasis.id.should_not == @emphasis.object_id
    end
  end

  describe '#occupation_data' do
    it 'responds' do
      @emphasis.should respond_to(:occupation_data)
    end

    it 'is an Array' do
      @emphasis.occupation_data.should be_a(Array)
    end

    it 'is an Array of Verso::ObjectData objects' do
      @emphasis.occupation_data.first.should be_a(Verso::OccupationData)
    end
  end
end
