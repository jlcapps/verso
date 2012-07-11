require 'spec_helper'

describe Verso::Task do
  context "when you are fetching full task" do
    before do
      @task = Verso::Task.new("code" => "6320", "edition" => "2011", "id" => "1")
    end

    it "fetches the full task" do
      @task.should_receive(:http_get).and_return(
        JSON.pretty_generate(:statement => "a statement")
      )
      @task.statement.should eq("a statement")
    end

    it "responds to standards" do
      @task.should_receive(:goals).and_return({})
      Verso::StandardsList.should_receive(:new)
      @task.standards
    end
  end

  context "when you are working from a short task" do
    before do
      @goals = { "a_body" => { "title" => "A Body",
                               "description" => "A Description",
                               "goals" => [],
                               "sections" => [] } }
      @task = Verso::Task.new("statement" => "Do this.", "id" => "12345",
                       "sensitive" => false, "essential" => true,
                       "goals" => @goals)
    end

    it "responds to #statement" do
      @task.statement.should eq("Do this.")
    end

    it "responds to #id" do
      @task.id.should eq("12345")
    end
    it "responds to #sensitive" do
      @task.sensitive.should eq(false)
    end

    it "responds to #essential" do
      @task.essential.should eq(true)
    end

    it "responds to #standards" do
      @standard = double("Verso::Standard", :title => "A Body")
      Verso::StandardsList.should_receive(:new).with(@goals).and_return([@standard])
      @task.standards.first.title.should eq("A Body")
    end
  end
end
