require 'spec_helper'

describe Verso::Credential do
  before do
    @credential = Verso::Credential.new("id" => 880)
    Net::HTTP.stub(:get).and_return(
      JSON.pretty_generate(
        :credential => { :id => 880, :title => "Computer Programming (NOCTI)",
                         :source => { :title => "National Occupational" },
                         :details => nil,
                         :related_courses => [{ :code => '6641' }] }
      )
    )
  end
  it 'responds to #id' do
    @credential.id.should eq(880)
  end

  it 'responds to #title' do
    @credential.title.should eq("Computer Programming (NOCTI)")
  end

  it 'responds to #source' do
    @credential.source.title.should eq("National Occupational")
  end

  it 'responds to #details' do
    @credential.details.should eq('')
  end

  it 'responds to #related_courses' do
    @credential.related_courses.first.code.should eq('6641')
  end
end
