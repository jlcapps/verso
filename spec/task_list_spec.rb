require 'spec_helper'

describe Verso::TaskList do
  use_vcr_cassette :record => :new_episodes

  before do
    @tl = Verso::TaskList.new(:code => "6320", :edition => "2011")
  end

  it "responds to #first" do
    @duty_area = double("Verso::DutyArea", :title => "A Verso::Duty Area")
    Verso::DutyArea.should_receive(:new).and_return(@duty_area)
    @tl.first.title.should eq("A Verso::Duty Area")
  end

  it "responds to #code, #edition" do
    @tl.code.should eq("6320")
    @tl.edition.should eq("2011")
  end

  it "responds to #has_optional_task? when true" do
    @tl.stub(:duty_areas).and_return(
      [{"title" => "DA Title",
        "tasks" => [
          { "statement" => "one",
            "sensitive" => false,
            "essential" => true }
        ]}]
    )
    @tl.has_optional_task?.should eq(false)
  end

  it "responds to #has_optional_task? when false" do
    @tl.stub(:duty_areas).and_return(
      [{"title" => "DA Title",
        "tasks" => [
          { "statement" => "one",
            "sensitive" => false,
            "essential" => false }
        ]}]
    )
    @tl.has_optional_task?.should eq(true)
  end

  it "responds to #has_sensitive_task? when true" do
    @tl.stub(:duty_areas).and_return(
      [{"title" => "DA Title",
        "tasks" => [
          { "statement" => "one",
            "sensitive" => true }
          ]}]
    )
    @tl.has_sensitive_task?.should eq(true)
  end

  it "responds to #has_sensitive_task? when false" do
    @tl.stub(:duty_areas).and_return(
      [{"title" => "DA Title",
        "tasks" => [
          { "statement" => "one",
            "sensitive" => false }
          ]}]
    )
    @tl.has_sensitive_task?.should eq(false)
  end

  it "should return an empty task list if none is published" do
    @tl = Verso::TaskList.new(:code => "1234", :edition => "1929")
    JSON.stub(:parse).and_return({ "errors" => "Not Found" })
    @tl.duty_areas.should eq([])
  end
end
