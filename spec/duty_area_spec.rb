require 'spec_helper'

describe Verso::DutyArea, :vcr do

  before do
    @da = Verso::CourseList.new(:code => "6320").last.duty_areas.last
  end

  describe '#id' do
    it 'responds' do
      @da.should respond_to(:id)
    end

    it 'is a String' do
      @da.id.should be_a(String)
    end

    it 'looks like an id' do
      @da.id.should match(/^\d+$/)
    end
  end

  describe '#code' do
    it "responds" do
      @da.should respond_to(:code)
    end

    it 'is a String' do
      @da.code.should be_a(String)
    end

    it 'is the code of our course' do
      @da.code.should == '6320'
    end
  end

  describe '#edition' do
    it "responds" do
      @da.should respond_to(:edition)
    end

    it 'is a String' do
      @da.edition.should be_a(String)
    end

    it 'looks like a year' do
      @da.edition.should match(/2\d{3}/)
    end
  end

  describe '#title' do
    it "responds" do
      @da.should respond_to(:title)
    end

    it 'is a String' do
      @da.title.should be_a(String)
    end
  end

  describe '#tasks' do
    it "responds" do
      @da.should respond_to(:tasks)
    end

    it 'is a collection of Verso::Task objects' do
      @da.tasks.first.should be_a(Verso::Task)
    end
  end
end
