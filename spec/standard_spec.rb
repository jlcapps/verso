require 'spec_helper'

describe Verso::Standard, :vcr do

  before do
    @standard = Verso::Standard.new(
      :code  => "6135",
      :edition => Verso::EditionList.new.last.year,
      :name => "english"
    )
  end

  describe '#description' do
    it 'responds' do
      @standard.should respond_to(:description)
    end

    it 'is a string' do
      @standard.description.should be_a(String)
    end
  end

  describe '#goals' do
    it 'responds' do
      @standard.should respond_to(:goals)
    end

    it 'is an Array' do
      @standard.goals.should be_a(Array)
    end

    it 'is an Array of OpenStruct objects' do
      @standard.goals.first.should be_a(OpenStruct)
    end

    describe 'OpenStruct goal objects' do
      before do
        @goal = @standard.goals.first
      end

      describe '#title' do
        it 'responds' do
          @goal.should respond_to(:title)
        end

        it 'is a string' do
          @goal.title.should be_a(String)
        end
      end

      describe '#description' do
        it 'responds' do
          @goal.should respond_to(:description)
        end

        it 'is a String' do
          @goal.description.should be_a(String)
        end

        it 'looks like HTML' do
          @goal.description.should match(/<\/.+>/)
        end
      end
    end
  end

  describe '#name' do
    it 'responds' do
      @standard.should respond_to(:name)
    end

    it 'is a String' do
      @standard.name.should be_a(String)
    end

    it 'looks like the title' do
      @standard.name.should == 'english'
    end
  end

  describe '#sections' do
    it 'responds' do
      @standard.should respond_to(:sections)
    end

    it 'is an Array' do
      @standard.sections.should be_a(Array)
    end

    it 'is an Array of Verso::Standard objects' do
      # english doesn't have subsections, so . . .
      std = Verso::Standard.new(
        :code => "8276",
        :edition => Verso::EditionList.new.last.year,
        :name => 'fccla_activities--competitive_events'
      )
      std.sections.first.should be_a(Verso::Standard)
    end
  end

  describe '#title' do
    it 'responds' do
      @standard.should respond_to(:title)
    end

    it 'is a String' do
      @standard.title.should be_a(String)
    end
  end
end
