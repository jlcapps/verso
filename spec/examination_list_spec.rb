require 'spec_helper'

describe Verso::ExaminationList do
  before do
    Net::HTTP.
      should_receive(:get).
      with('api.cteresource.org', "/examinations/", 80).
      and_return(
        JSON.pretty_generate(
          :examinations => [ { :passing_score => "3",
                               :source => "NOCTI",
                               :title => "AP Computer Science",
                               :retired => false,
                               :amt_seal => true } ]
        )
      )
    @examinations = Verso::ExaminationList.new
  end

  it 'responds to #first' do
    exam = @examinations.first
    exam.title.should eq("AP Computer Science")
  end

  it 'responds to #last' do
    exam = @examinations.last
    exam.title.should eq("AP Computer Science")
  end
end
