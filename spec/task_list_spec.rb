require 'spec_helper'
require 'shared_verso_list_examples'

describe Verso::TaskList do
  use_vcr_cassette :record => :new_episodes

  before do
    @list = Verso::TaskList.new(
      :code => "6320",
      :edition => Verso::EditionList.new.last.year
    )
    @kontained = Verso::DutyArea
  end

  it_behaves_like 'any Verso list'

  describe '#code' do
    it 'responds' do
      @list.should respond_to(:code)
    end

    it 'is a String' do
      @list.code.should be_a(String)
    end
  end

  describe '#edition' do
    it 'responds' do
      @list.should respond_to(:edition)
    end

    it 'is a String' do
      @list.edition.should be_a(String)
    end
  end

  describe '#has_optional_task?' do
    it 'responds' do
      @list.should respond_to(:has_optional_task?)
    end

    it 'is Boolean' do
      @list.has_optional_task?.to_s.should match(/true|false/)
    end

    it 'is true if a task is non-essential' do
      tl = Verso::TaskList.new(
        :code => "6320",
        :edition => Verso::EditionList.new.last.year,
        :duty_areas => [
          { :title => "",
            :tasks => [
              { :statement => '', :id => "12",
                :sensitive => false, :essential => false }
            ]
        }]
      )
      tl.has_optional_task?.should be_true
    end

    it 'is false if all tasks are essential' do
      tl = Verso::TaskList.new(
        :code => "6320",
        :edition => Verso::EditionList.new.last.year,
        :duty_areas => [
          { :title => "",
            :tasks => [
              { :statement => '', :id => "12",
                :sensitive => false, :essential => true }
            ]
        }]
      )
      tl.has_optional_task?.should be_false
    end
  end

  describe '#has_sensitive_task?' do
    it 'responds' do
      @list.should respond_to(:has_sensitive_task?)
    end

    it 'is Boolean' do
      @list.has_sensitive_task?.to_s.should match(/true|false/)
    end

    it 'is false if no task is sensitive' do
      @list.has_sensitive_task?.should be_false
    end

    it 'is true if a task is sensitive' do
      tl = Verso::TaskList.new(
        :code => "6320",
        :edition => Verso::EditionList.new.last.year,
        :duty_areas => [
          { :title => "",
            :tasks => [
              { :statement => '', :id => "12",
                :sensitive => true, :essential => true }
            ]
        }]
      )
      tl.has_sensitive_task?.should be_true
    end
  end
  it "is empty if no task list is published" do
    tl = Verso::TaskList.new(:code => "1234", :edition => "1929")
    tl.should be_empty
  end
end
