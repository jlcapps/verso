require 'spec_helper'

describe Verso::Course, :vcr do

  before do
    @course = Verso::Course.new(:code => "6321",
                                :edition => Verso::EditionList.new.last.year)
  end

  describe '#certifications' do
    it 'responds' do
      @course.should respond_to(:certifications)
    end

    it 'is an Array' do
      @course.certifications.should be_a(Array)
    end

    it 'is an Array of Verso::Credential objects' do
      @course.certifications.first.should be_a(Verso::Credential)
    end

    it "is an Array of Verso::Credential objects with type 'Certification'" do
      @course.certifications.first.type.should == 'Certification'
    end
  end

  describe '#co_op' do
    it 'responds' do
      @course.should respond_to(:co_op)
    end

    it 'is Boolean' do
      @course.co_op.should be_true
    end
  end

  describe '#co_op?' do
    it 'responds' do
      @course.should respond_to(:co_op?)
    end

    it 'is Boolean' do
      @course.should be_co_op
    end
  end

  describe '#complement' do
    it 'responds' do
      @course.should respond_to(:complement)
    end

    it 'is Boolean' do
      @course.complement.should be_false
    end
  end

  describe '#complement?' do
    it 'responds' do
      @course.should respond_to(:complement?)
    end

    it 'is Boolean' do
      @course.should_not be_complement
    end
  end

  describe '#code' do
    it 'responds' do
      @course.should respond_to(:code)
    end

    it 'is a String' do
      @course.code.should be_a(String)
    end

    it 'looks like a course code' do
      @course.code.should match(/\d{4}/)
    end
  end

  describe '#credentials' do
    it 'responds' do
      @course.should respond_to(:credentials)
    end

    it 'is an Array' do
      @course.credentials.should be_a(Array)
    end

    it 'is an Array of Verso::Credential objects' do
      @course.credentials.first.should be_a(Verso::Credential)
    end
  end

  describe '#description' do
    it 'responds' do
      @course.should respond_to(:description)
    end

    it 'is a String' do
      @course.description.should be_a(String)
    end

    it 'looks like HTML' do
      @course.description.should match(/<\/.+>/)
    end
  end

  describe '#duration' do
    it 'responds' do
      @course.should respond_to(:duration)
    end

    it 'is a Fixnum' do
      @course.duration.should be_a(Fixnum)
    end
  end

  describe '#duty_areas' do
    it 'responds' do
      @course.should respond_to(:duty_areas)
    end

    it 'is a Verso::TaskList' do
      @course.duty_areas.should be_a(Verso::TaskList)
    end
  end

  describe '#extras' do
    it 'responds' do
      @course.should respond_to(:extras)
    end

    it 'is a Verso::ExtrasList' do
      @course.extras.should be_a(Verso::ExtrasList)
    end
  end

  describe '#frontmatter' do
    it 'responds' do
      @course.should respond_to(:frontmatter)
    end

    it 'is a Verso::Frontmatter object' do
      @course.frontmatter.should be_a(Verso::Frontmatter)
    end
  end

  describe '#grade_levels' do
    it 'responds' do
      @course.should respond_to(:grade_levels)
    end

    it 'is a String' do
      @course.grade_levels.should be_a(String)
    end

    it 'looks like grade levels' do
      @course.grade_levels.should match(/\d{1,2} \d/)
    end
  end

  describe '#hours' do
    it 'responds' do
      @course.should respond_to(:hours)
    end

    it 'is Fixnum or nil' do
      @course.hours.should  == nil
      dental = Verso::Course.new(:code => "8328",
                                 :edition => Verso::EditionList.new.last.year)
      dental.hours.should be_a(Fixnum)
    end
  end

  describe '#hs_credit_in_ms' do
    it 'responds' do
      @course.should respond_to(:hs_credit_in_ms)
    end

    it 'is Boolean' do
      @course.hs_credit_in_ms.should be_false
    end
  end

  describe '#hs_credit_in_ms?' do
    it 'responds' do
      @course.should respond_to(:hs_credit_in_ms?)
    end

    it 'is Boolean' do
      @course.should_not be_hs_credit_in_ms
    end
  end

  describe '#is_ms?' do
    it 'responds' do
      @course.should respond_to(:is_ms?)
    end

    it 'is Boolean' do
      @course.is_ms?.should be_false
    end

    it 'is not middle school' do
      @course.should_not be_is_ms
    end
  end

  describe '#is_hs?' do
    it 'responds' do
      @course.should respond_to(:is_hs?)
    end

    it 'is Boolean' do
      @course.is_hs?.should be_true
    end

    it 'is high school' do
      @course.should be_is_hs
    end
  end

  describe '#licenses' do
    before(:each) do
      @barber = Verso::Course.new(:code => "8740",
                                  :edition => Verso::EditionList.new.last.year)
    end

    it 'responds' do
      @barber.should respond_to(:licenses)
    end

    it 'is an Array' do
      @barber.licenses.should be_a(Array)
    end

    it 'is an Array of Verso::Credential objects' do
      @barber.licenses.first.should be_a(Verso::Credential)
    end

    it "is an Array of Verso::Credential objects with type 'License'" do
      @barber.licenses.first.type.should == 'License'
    end
  end

  describe '#occupation_data' do
    it 'responds' do
      @course.should respond_to(:occupation_data)
    end

    it 'is an Array' do
      @course.occupation_data.should be_a(Array)
    end

    it 'is an Array of Verso::OccupationData objects' do
      @course.occupation_data.first.should be_a(Verso::OccupationData)
    end
  end

  describe '#osha_exempt' do
    it 'responds' do
      @course.should respond_to(:osha_exempt)
    end

    it 'is Boolean' do
      @course.osha_exempt.should be_false
    end
  end

  describe '#osha_exempt?' do
    it 'responds' do
      @course.should respond_to(:osha_exempt?)
    end

    it 'is Boolean' do
      @course.osha_exempt?.should be_false
    end
  end

  describe '#prerequisite_courses' do
    it 'responds' do
      @course.should respond_to(:prerequisite_courses)
    end

    it 'is an Array' do
      @course.prerequisite_courses.should be_a(Array)
    end

    it 'is an Array of Verso::Course objects' do
      @course.prerequisite_courses.first.should be_a(Verso::Course)
    end
  end

  describe '#prerequisites' do
    it 'responds' do
      @course.should respond_to(:prerequisites)
    end

    it 'is an Array' do
      @course.prerequisites.should be_a(Array)
    end

    it 'is an Array of Verso::Course objects' do
      @course.prerequisites.first.should be_a(Verso::Course)
    end
  end

  describe '#related_courses' do
    it 'responds' do
      @course.should respond_to(:related_courses)
    end

    it 'is an Array' do
      @course.related_courses.should be_a(Array)
    end

    it 'is an Array of Verso::Course objects' do
      @course.related_courses.first.should be_a(Verso::Course)
    end
  end

  describe '#related_resources' do
    it 'responds' do
      @course.should respond_to(:related_resources)
    end

    it 'is an Array' do
      @course.related_resources.should be_a(Array)
    end

    it 'is an Array of Strings' do
      @course.related_resources.first.should be_a(String)
    end

    it "includes 'tasks'" do
      @course.related_resources.should include('tasks')
    end
  end

  describe '#standards' do
    it 'responds' do
      @course.should respond_to(:standards)
    end

    it 'is a Verso::StandardsList' do
      @course.standards.should be_a(Verso::StandardsList)
    end
  end

  describe '#task' do
    it 'responds' do
      @course.should respond_to(:task)
    end

    it 'returns a Verso::Task object' do
      task_id = @course.duty_areas.last.tasks.first.id
      @course.task(task_id).should be_a(Verso::Task)
    end
  end

  describe '#tasklist' do
    it 'responds' do
      @course.should respond_to(:tasklist)
    end

    it 'is a Verso::TaskList' do
      @course.tasklist.should be_a(Verso::TaskList)
    end
  end

  describe '#title' do
    it 'responds' do
      @course.should respond_to(:title)
    end

    it 'is a String' do
      @course.title.should be_a(String)
    end

    it 'is about Accounting' do
      @course.title.should match(/Accounting/)
    end
  end
end
