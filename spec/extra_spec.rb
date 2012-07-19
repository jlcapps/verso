require 'spec_helper'

describe Verso::Extra do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @extra = Verso::CourseList.new(:code => "6320").last.extras.first
  end

  describe '#code' do
    it 'responds' do
      @extra.should respond_to(:code)
    end

    it 'is a String' do
      @extra.code.should be_a(String)
    end

    it 'looks like a code' do
      @extra.code.should match(/\d{4}/)
    end
  end

  describe '#description' do
     it 'responds' do
       @extra.should respond_to(:description)
     end

     it 'is a String' do
       @extra.description.should be_a(String)
     end

     it 'looks like HTML' do
       @extra.description.should match(/<\/.+>/)
     end
  end

  describe '#edition' do
    it 'responds' do
      @extra.should respond_to(:edition)
    end

    it 'is a String' do
      @extra.edition.should be_a(String)
    end

    it 'looks like a year' do
      @extra.edition.should match(/2\d{3}/)
    end
  end

  describe '#name' do
    it 'responds' do
      @extra.should respond_to(:name)
    end

    it 'is a String' do
      @extra.name.should be_a(String)
    end

    it 'looks like a name (i.e., untitled~6320)' do
      @extra.name.should match(/^[a-z_~\d]+$/)
    end
  end

  describe '#title' do
    it 'responds' do
      @extra.should respond_to(:title)
    end

    it 'is a String' do
      @extra.title.should be_a(String)
    end
  end
end
