require 'spec_helper'

describe Verso::Extra do
  before do
    Net::HTTP.stub(:get).
      with('api.cteresource.org',
           "/courses/6320,2011/extras/untitled~6320",
           80).
      and_return(JSON.pretty_generate(
        :extra => { :title => "Instructional Scenario",
                    :description => "extra description" }
      ))
    @extra = Verso::Extra.new("code" => "6320", "edition" => "2011",
                       "name" => "untitled~6320",
                       "title" => "Instructional Scenarios")
  end

  it "responds to #title" do
    @extra.title.should eq("Instructional Scenarios")
  end

  it "responds to #description" do
    @extra.description.should eq("extra description")
  end
  it "responds to #code" do
    @extra.code.should eq("6320")
  end

  it "resonds to #name" do
    @extra.name.should eq("untitled~6320")
  end

  it "responds to #edition" do
    @extra.edition.should eq("2011")
  end
end
