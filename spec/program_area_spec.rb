require 'spec_helper'

describe Verso::ProgramArea do
  use_vcr_cassette :record => :new_episodes

  before do
    @pa = Verso::ProgramArea.new("title" => "Career Connections")
  end

  describe '#courses' do
    it 'responds' do
      @pa.should respond_to(:courses)
    end

    it 'is an Array' do
      @pa.courses.should be_a(Array)
    end

    it 'is an Array of Verso::Course objects' do
      @pa.courses.first.should be_a(Verso::Course)
    end
  end

  describe '#deprecated' do
    it 'responds' do
      @pa.should respond_to(:deprecated)
    end

    it 'is Boolean' do
      @pa.deprecated.to_s.should match(/true|false/)
    end
  end

  describe '#description' do
    it 'responds' do
      @pa.should respond_to(:description)
    end

    it 'is a String' do
      @pa.description.should be_a(String)
    end
  end

  describe '#section_overview' do
    it 'responds' do
      @pa.should respond_to(:section_overview)
    end

    it 'is a String' do
      @pa.section_overview.should be_a(String)
    end

    it 'is HTML' do
      @pa.section_overview.should match(/<\/.+>/)
    end
  end

  describe '#slug' do
    it 'responds' do
      @pa.should respond_to(:slug)
    end

    it 'is a string' do
      @pa.slug.should be_a(String)
    end

    it 'looks like the title' do
      @pa.slug.should == 'career-connections'
    end
  end

  describe '#title' do
    it 'responds' do
      @pa.should respond_to(:title)
    end

    it 'is a String' do
      @pa.title.should be_a(String)
    end
  end

  describe '#version_date' do
    it 'responds' do
      @pa.should respond_to(:version_date)
    end
  end
end
