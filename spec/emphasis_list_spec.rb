require 'spec_helper'

describe Verso::EmphasisList do
  use_vcr_cassette :record => :new_episodes

  before do
    @emphases = Verso::EmphasisList.new
  end

  describe 'array-like behavior' do
    describe '#[]' do
      it 'responds' do
        @emphases.should respond_to(:[])
      end

      it 'gets a Verso::Emphasis object' do
        @emphases[10].should be_a(Verso::Emphasis)
      end
    end

    describe '#each' do
      it 'responds' do
        @emphases.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @emphases.each("foo", &b).to yield_control }
      end

      it 'yields Verso::Emphasis objects' do
        @emphases.each { |c| c.should be_a(Verso::Emphasis) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @emphases.should respond_to(:empty?)
      end

      it 'is not empty' do
        @emphases.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @emphases.should respond_to(:last)
      end

      it 'is a Verso::Emphasis object' do
        @emphases.last.should be_a(Verso::Emphasis)
      end
    end

    describe '#length' do
      it 'responds' do
        @emphases.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @emphases.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @emphases.should respond_to(:first)
      end

      it 'is a Verso::Emphasis object' do
        @emphases.first.should be_a(Verso::Emphasis)
      end
    end

    describe '#count' do
      it 'responds' do
        @emphases.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @emphases.count.should be_a(Fixnum)
      end
    end
  end
end
