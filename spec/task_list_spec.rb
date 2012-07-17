require 'spec_helper'

describe Verso::TaskList do
  use_vcr_cassette :record => :new_episodes

  before do
    @edition = Verso::EditionList.new.last.year
    @tl = Verso::TaskList.new(:code => "6320", :edition => @edition)
  end

  it "responds to #first" do
    @tl.first.should be_a(Verso::DutyArea)
  end

  it "responds to #code, #edition" do
    @tl.code.should eq("6320")
    @tl.edition.should eq(@edition)
  end

  it "responds to #has_optional_task? when true" do
    @tl.stub(:duty_areas).
      and_return(
        [Verso::DutyArea.new(
          {"title" => "DA Title",
           "tasks" => [
             { "statement" => "one",
               "sensitive" => false,
               "essential" => false }]},
          @tl
        )]
      )
    @tl.has_optional_task?.should eq(true)
  end

  it "responds to #has_optional_task? when false" do
    @tl.stub(:duty_areas).
      and_return(
        [Verso::DutyArea.new(
          {"title" => "DA Title",
           "tasks" => [
             { "statement" => "one",
               "sensitive" => false,
               "essential" => true }]},
          @tl
        )]
      )
    @tl.has_optional_task?.should eq(false)
  end

  it "responds to #has_sensitive_task? when true" do
    @tl.stub(:duty_areas).
      and_return(
        [Verso::DutyArea.new(
          {"title" => "DA Title",
           "tasks" => [
             { "statement" => "one",
               "sensitive" => true,
               "essential" => true }]},
          @tl
        )]
      )
    @tl.has_sensitive_task?.should eq(true)
  end

  it "responds to #has_sensitive_task? when false" do
    @tl.stub(:duty_areas).
      and_return(
        [Verso::DutyArea.new(
          {"title" => "DA Title",
           "tasks" => [
             { "statement" => "one",
               "sensitive" => false,
               "essential" => true }]},
          @tl
        )]
      )
    @tl.has_sensitive_task?.should eq(false)
  end

  it "should return an empty task list if none is published" do
    @tl = Verso::TaskList.new(:code => "1234", :edition => "1929")
    @tl.duty_areas.should eq([])
  end
end
