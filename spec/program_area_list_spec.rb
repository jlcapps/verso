require 'spec_helper'

describe Verso::ProgramAreaList do
  use_vcr_cassette :record => :new_episodes

  before do
    @list = Verso::ProgramAreaList.new
  end

  describe '#[]' do
    it 'responds' do
      @list.should respond_to(:[])
    end

    it 'is a Verso::ProgramArea object' do
      @list[3].should be_a(Verso::ProgramArea)
    end
  end

  describe '#each' do
    it 'responds' do
      @list.should respond_to(:each)
    end

    it 'yields' do
      expect { |b| @list.each("foo", &b).to yield_control }
    end

    it 'yields Verso::ProgramArea objects' do
      @list.each do |c|
        c.should be_a(Verso::ProgramArea)
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

    it 'is a Verso::ProgramArea object' do
      @list.last.should be_a(Verso::ProgramArea)
    end
  end

  describe '#length' do
    it 'responds' do
      @list.should respond_to(:length)
    end

    it 'is a Fixnum' do
      @list.length.should be_a(Fixnum)
    end
  end

  describe '#first' do
    it 'responds' do
      @list.should respond_to(:first)
    end

    it 'is a Verso::ProgramArea object' do
      @list.first.should be_a(Verso::ProgramArea)
    end
  end

  describe '#count' do
    it 'responds' do
      @list.should respond_to(:count)
    end

    it 'is a Fixnum' do
      @list.count.should be_a(Fixnum)
    end
  end
end
