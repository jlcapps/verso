require 'spec_helper'

describe Verso::ExtrasList do
  before do
    @extra = double("Verso::Extra", :code => "6320", :edition => "2011",
                    :name => "untitled~6320",
                    :title => "Instructional Scenarios")
    @extras_list = Verso::ExtrasList.new(:code => "6320", :edition => "2011")
    Net::HTTP.stub(:get).and_return(
      JSON.pretty_generate(
        :extras => [
          { :title => "Instructional Scenarios", :name => "untitled~6320" }
        ]
      )
    )
  end

  it "responds as Enumerable" do
    Verso::Extra.should_receive(:new).
      with(:title => "Instructional Scenarios",
           :name => "untitled~6320", :code => "6320", :edition => "2011",
           ).
      and_return(@extra)
    @extras_list.first.title.should eq("Instructional Scenarios")
  end
end
