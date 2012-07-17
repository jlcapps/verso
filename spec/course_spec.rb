require 'spec_helper'

describe Verso::Course do
  before do
    credentials = [{
      "title" => "Certification 1", "type" => "Certification"
    },
      {"title" => "License 1", "type" => "License" }]
    prerequisite_courses = [{
      "code" => "2222", "hours" => nil, "duration" => 36,
      "title" => "Basketweaving", "co_op" => true
    }]
    occupation_data = [{
      "cluster" => { "title" => "Information Technology" },
      "pathway" => { "title" => "Information and Support Services" },
      "occupations" => [{ "title" => "Database Analyst" }]
    }]
    @extra = double("ExtrasList", :title => "Extra Title",
                    :name => "extra_name")
    @course = Verso::Course.new("code" => "6321", "duration" => 36,
                         "title" => "Accounting, Advanced",
                         "hours" => nil, "edition" => "2011",
                         "co_op" => true,
                         "related_resources" => ["extras", "standards"],
                         "grade_levels" => "8 9 10",
                         "credentials" => credentials,
                         "occupation_data" => occupation_data,
                         "related_courses" => prerequisite_courses,
                         "prerequisite_courses" => prerequisite_courses)
  end

  it "responds to #extras" do
    Verso::ExtrasList.should_receive(:new).and_return([@extra])
    @course.extras.first.title.should eq("Extra Title")
  end

  it "responds to #related_courses" do
    @course.related_courses.first.code.should eq('2222')
  end

  it "responds to #is_ms?" do
    @course.is_ms?.should eq(true)
  end

  it "responds to #is_hs?" do
    @course.is_hs?.should eq(true)
  end

  it "responds to #code" do
    @course.code.should eq("6321")
  end

  it "responds to #duration" do
    @course.duration.should eq(36)
  end

  it "responds to #title" do
    @course.title.strip.should eq("Accounting, Advanced")
  end

  it "responds to #edition" do
    @course.edition.should eq("2011")
  end

  it "responds to #hours" do
    dental = Verso::Course.new("hours" => 280)
    dental.hours.should eq(280)
  end

  it "responds to #co_op" do
    @course.co_op.should eq(true)
    Verso::Course.new("co_op" => false).co_op.should eq(false)
  end

  it "responds to #duty_areas" do
    @task = double("Task", :statement => "a task", :id => "999999",
                    :sensitive => false, :essential => true)
    @duty_area = double("DutyArea", :title => "A Duty Area",
                        :tasks => [@task])
    Verso::TaskList.should_receive(:new).
      with(:code => "6321", :edition => "2011").
      and_return([@duty_area])
    @course.duty_areas.first.should eq(@duty_area)
  end

  it "responds to #occupation_data" do
    @occupation = double("Occupation", :title => "Database Analyst")
    @pathway = double("Pathway", :title => "Information Support and Services")
    @cluster = double("Cluster", :title => "Information Technology")
    @occlist = double("OccupationData",
                      :cluster => @cluster,
                      :occupations => [@occupation],
                      :pathway => @pathway)
    Verso::OccupationData.should_receive(:new).and_return(@occlist)
    @course.occupation_data.first.should eq(@occlist)
  end

  it "responds to prerequisites" do
    @course.prerequisites.first.code.should eq('2222')
  end

  it "responds to credentials" do
    @course.credentials.first.title.should eq("Certification 1")
    @course.credentials.last.title.should eq("License 1")
  end

  it "responds to certifications" do
    @course.certifications.first.title.should eq("Certification 1")
    @course.certifications.count.should eq(1)
  end

  it "responds to licenses" do
    @course.licenses.first.title.should eq("License 1")
    @course.licenses.count.should eq(1)
  end

  it "responds to #standards" do
    Verso::StandardsList.
      should_receive(:from_course).
      with(@course).
      and_return(["phony"])
    @course.stub(:method_missing).and_return(["standards"])
    @course.standards.first.should eq("phony")
  end

  it "responds to #task" do
    t = Verso::Task.new("code" => @course.code, "edition" => @course.edition,
                        "id" => 99999999)
    Verso::Task.should_receive(:new).
      with("code" => @course.code,
           "edition" => @course.edition,
           "id" => 99999999).
      and_return(t)
    t = @course.task(99999999)
    t.code.should eq(@course.code)
  end

  it "responds to #frontmatter" do
    Verso::Frontmatter.should_receive(:new).
      with("code" => @course.code,
           "edition" => @course.edition).
      and_return("phony")
    @course.stub(:related_resources).and_return(["frontmatter"])
    @course.frontmatter.should eq("phony")
  end

  it "#frontmatter returns nil if there is no frontmatter" do
    @course.stub(:related_resources).and_return([])
    @course.frontmatter.should eq(nil)
  end

  context "Only code and edition specified" do
    use_vcr_cassette :record => :new_episodes

    before do
      @course = Verso::Course.new("code" => 6320, "edition" => "2011")
    end

    it "responds to #title" do
      @course.title.should eq("Accounting")
    end
  end

  context "MS-only course" do
    before do
      @course = Verso::Course.new("code" => "6320", "edition" => "2011",
                           "grade_levels" => "8")
    end

    it 'knows it is ms' do
      @course.is_ms?.should eq(true)
    end

    it 'knows it is not hs' do
      @course.is_hs?.should eq(false)
    end
  end

  context 'HS-only course' do
    before do
      @course = Verso::Course.new("code" => "6320", "edition" => "2011",
                           "grade_levels" => "10")
    end

    it 'knows it is not ms' do
      @course.is_ms?.should eq(false)
    end

    it 'knows it is hs' do
      @course.is_hs?.should eq(true)
    end
  end
end
