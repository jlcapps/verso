require 'spec_helper'

describe Verso::DutyArea do
  before do
    context = double("context", :code => "6320", :edition => "2012")
    @duty_area = Verso::DutyArea.new({
      "title" => "A Duty Area",
      "tasks" => [{ "statement" => "Do this.",
      "id" => "12345",
      "sensitive" => false,
      "essential" => true } ]},
      context
    )
    @task = double("Task", :statement => "Do this.", :id => "12345",
                   :sensitive => false, :essential => true,
                   :code => "6320", :edition => "2012")
  end

  it "responds to #title" do
    @duty_area.title.should eq("A Duty Area")
  end

  it "responds to #tasks" do
    Verso::Task.should_receive(:new).and_return(@task)
    @duty_area.tasks.first.statement.should eq("Do this.")
  end
end
