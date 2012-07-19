require 'spec_helper'

describe Verso::Occupation do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @occ = Verso::OccupationList.new(:text => "golf").first.occupations.first
  end

  describe '#description' do
    it 'responds' do
      @occ.should respond_to(:description)
    end

    it 'is a String' do
      @occ.description.should be_a(String)
    end

    it 'is HTML' do
      @occ.description.should match(/<\/.+>/)
    end
  end

  describe '#id' do
    it 'responds' do
      @occ.should respond_to(:id)
    end

    it 'is a Fixnum' do
      @occ.id.should be_a(Fixnum)
    end

    it 'is not the same as #object_id' do
      @occ.id.should_not == @occ.object_id
    end
  end

  describe '#pathway' do
    it 'responds' do
      @occ.should respond_to(:pathway)
    end

    it 'is a Verso::Pathway' do
      @occ.pathway.should be_a(Verso::Pathway)
    end
  end

  describe '#preparations' do
    it 'responds' do
      @occ.should respond_to(:preparations)
    end

    it 'is an Array' do
      @occ.preparations.should be_a(Array)
    end

    it 'is an Array of Strings' do
      @occ.preparations.first.should be_a(String)
    end
  end

  describe '#related_courses' do
    it 'responds' do
      @occ.should respond_to(:related_courses)
    end

    it 'is an Array' do
      @occ.related_courses.should be_a(Array)
    end

    it 'is an Array of Verso::Course objects' do
      @occ.related_courses.first.should be_a(Verso::Course)
    end
  end

  describe '#title' do
    it 'responds' do
      @occ.should respond_to(:title)
    end

    it 'is a String' do
      @occ.title.should be_a(String)
    end
  end
end
