require 'spec_helper'

describe Verso::OccupationList do
  use_vcr_cassette :record => :new_episodes

  describe 'array-like behavior' do
    before(:each) do
      @occupations = Verso::OccupationList.new(:text => "teacher")
    end

    describe '#[]' do
      it 'responds' do
        @occupations.should respond_to(:[])
      end

      it 'gets a Verso::OccupationData object' do
        @occupations[10].should be_a(Verso::OccupationData)
      end
    end

    describe '#each' do
      it 'responds' do
        @occupations.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @occupations.each("foo", &b).to yield_control }
      end

      it 'yields Verso::OccupationData objects' do
        @occupations.each { |c| c.should be_a(Verso::OccupationData) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @occupations.should respond_to(:empty?)
      end

      it 'is not empty' do
        @occupations.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @occupations.should respond_to(:last)
      end

      it 'is a Verso::OccupationData object' do
        @occupations.last.should be_a(Verso::OccupationData)
      end
    end

    describe '#length' do
      it 'responds' do
        @occupations.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @occupations.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @occupations.should respond_to(:first)
      end

      it 'is a Verso::OccupationData object' do
        @occupations.first.should be_a(Verso::OccupationData)
      end
    end

    describe '#count' do
      it 'responds' do
        @occupations.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @occupations.count.should be_a(Fixnum)
      end
    end
  end

  it 'returns an empty array if the search is empty' do
    Verso::OccupationList.new.should be_empty
  end

  it "searches by text" do
    results = Verso::OccupationList.new(:text => "golf")
    results.first.occupations.first.title.should match(/Turf/)
  end
end
