require 'spec_helper'

describe Verso::Task do
  use_vcr_cassette :record => :new_episodes

  before(:each) do
    @task = Verso::CourseList.new(:code => "6320").
      last.
      duty_areas.
      to_a.last.
      tasks.
      first
  end

  describe '#code' do
    it 'responds' do
      @task.should respond_to(:code)
    end

    it 'is a String' do
      @task.code.should be_a(String)
    end
  end

  describe '#definition' do
    it 'responds' do
      @task.should respond_to(:definition)
    end

    it 'is a Sring' do
      @task.definition.should be_a(String)
    end

    it 'looks like HTML' do
      @task.definition.should match(/<\/.+>/)
    end
  end

  describe '#edition' do
    it 'responds' do
      @task.should respond_to(:edition)
    end

    it 'is a String' do
      @task.edition.should be_a(String)
    end
  end

  describe '#essential' do
    it 'responds' do
      @task.should respond_to(:essential)
    end

    it 'is a Boolean' do
      @task.essential.to_s.should match(/true|false/)
    end
  end

  describe '#essential?' do
    it 'responds' do
      @task.should respond_to(:essential?)
    end

    it 'is a Boolean' do
      @task.essential?.to_s.should match(/true|false/)
    end
  end

  describe '#goals' do
    it 'responds' do
      @task.should respond_to(:goals)
    end

    it 'is a Verso::StandardsList' do
      @task.goals.should be_a(Verso::StandardsList)
    end
  end

  describe '#id' do
    it 'responds' do
      @task.should respond_to(:id)
    end

    it 'is a Fixnum' do
      @task.id.should be_a(String)
    end

    it 'is not the same as #object_id' do
      @task.id.should_not == @task.object_id
    end
  end

  describe '#questions' do
    it 'responds' do
      @task.should respond_to(:questions)
    end

    it 'is a String' do
      @task.questions.should be_a(String)
    end
  end

  describe '#sensitive' do
    it 'responds' do
      @task.should respond_to(:sensitive)
    end

    it 'is a Boolean' do
      @task.sensitive.to_s.should match(/true|false/)
    end
  end

  describe '#sensitive?' do
    it 'responds' do
      @task.should respond_to(:sensitive?)
    end

    it 'is a Boolean' do
      @task.sensitive?.to_s.should match(/true|false/)
    end
  end

  describe '#standards' do
    it 'responds' do
      @task.should respond_to(:standards)
    end

    it 'is a Verso::StandardsList' do
      @task.standards.should be_a(Verso::StandardsList)
    end
  end

  describe '#statement' do
    it 'responds' do
      @task.should respond_to(:statement)
    end

    it 'is a String' do
      @task.statement.should be_a(String)
    end
  end
end
