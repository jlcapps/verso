require 'spec_helper'

describe Verso::ExaminationList do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @exams = Verso::ExaminationList.new
  end

  describe 'array-like behavior' do
    describe '#[]' do
      it 'responds' do
        @exams.should respond_to(:[])
      end

      it 'gets a OpenStruct object' do
        @exams[3].should be_a(OpenStruct)
      end
    end

    describe '#each' do
      it 'responds' do
        @exams.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @exams.each("foo", &b).to yield_control }
      end

      it 'yields OpenStruct objects' do
        @exams.each { |c| c.should be_a(OpenStruct) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @exams.should respond_to(:empty?)
      end

      it 'is not empty' do
        @exams.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @exams.should respond_to(:last)
      end

      it 'is a OpenStruct object' do
        @exams.last.should be_a(OpenStruct)
      end
    end

    describe '#length' do
      it 'responds' do
        @exams.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @exams.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @exams.should respond_to(:first)
      end

      it 'is a OpenStruct object' do
        @exams.first.should be_a(OpenStruct)
      end
    end

    describe '#count' do
      it 'responds' do
        @exams.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @exams.count.should be_a(Fixnum)
      end
    end
  end

  describe 'OpenStruct Examination stand-in' do
    before(:each) do
      @exam = Verso::ExaminationList.new.first
    end

    describe '#amt_seal' do
      it 'responds' do
        @exam.should respond_to(:amt_seal)
      end

      it 'is a Boolean' do
        @exam.amt_seal.to_s.should match(/true|false/)
      end
    end

    describe '#passing_score' do
      it 'responds' do
        @exam.should respond_to(:passing_score)
      end

      it 'is a String' do
        @exam.passing_score.should be_a(String)
      end

      it 'looks like a number' do
        @exam.passing_score.should match(/\d+/)
      end
    end

    describe '#retired' do
      it 'responds' do
        @exam.should respond_to(:retired)
      end

      it 'is a Boolean' do
        @exam.retired.to_s.should match(/true|false/)
      end
    end

    describe '#source' do
      it 'responds' do
        @exam.should respond_to(:source)
      end

      it 'is a String' do
        @exam.source.should be_a(String)
      end
    end

    describe '#title' do
      it 'responds' do
        @exam.should respond_to(:title)
      end

      it 'is a String' do
        @exam.title.should be_a(String)
      end
    end

    describe '#verified_credit' do
      it 'responds' do
        @exam.should respond_to(:verified_credit)
      end

      it 'is a Boolean' do
        @exam.verified_credit.to_s.should match(/true|false/)
      end
    end
  end
end
