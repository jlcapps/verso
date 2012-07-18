require 'spec_helper'

describe Verso::CorrelationList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @list = Verso::CorrelationList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year,
      :name => "english"
    )
  end

  describe '#code' do
    it { @list.code.should == '6320' }
  end

  describe '#edition' do
    it { @list.edition.should match(/2\d{3}/) }
  end

  describe '#name' do
    it { @list.name.should == 'english' }
  end

  describe '#title' do
    it { @list.title.should == 'English' }
  end

  describe '#[]' do
    it 'responds' do
      @list.should respond_to(:[])
    end

    it 'is a Verso::Task' do
      @list[@list.count / 2].should be_a(Verso::Task)
    end
  end

  describe '#each' do
    it 'responds' do
      @list.should respond_to(:each)
    end

    it 'yields' do
      expect { |b| @list.each("foo", &b).to yield_control }
    end

    it 'yields a Verso::Task' do
      @list.each do |t|
        t.should be_a(Verso::Task)
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

    it 'is a Verso::Task' do
      @list.last.should be_a(Verso::Task)
    end
  end

  describe '#length' do
    it 'responds' do
      @list.should respond_to(:length)
    end

    it 'is a Fixnum' do
      @list.length.should be_a(Fixnum)
    end

    it 'is not zero' do
      @list.length.should_not == 0
    end
  end

  describe '#first' do
    it 'responds' do
      @list.should respond_to(:first)
    end

    it 'is a Verso::Task' do
      @list.first.should be_a(Verso::Task)
    end
  end

  describe '#count' do
    it 'responds' do
      @list.should respond_to(:count)
    end

    it 'is a Fixnum' do
      @list.count.should be_a(Fixnum)
    end

    it 'is not zero' do
      @list.count.should_not == 0
    end
  end
end
