require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::ExaminationList, :vcr, :vcr do
  before(:each) do
    @list = Verso::ExaminationList.new
    @kontained = OpenStruct
  end

  it_behaves_like 'any Verso list'

  describe 'OpenStruct Examination stand-in' do
    before(:each) do
      @exam = @list.first
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
