require 'spec_helper'

describe Verso::CredentialList do
  context "complete list" do
    before do
      Net::HTTP.
        should_receive(:get).
        with('api.cteresource.org', "/credentials", 80).
        and_return(
          JSON.pretty_generate(
            :credentials => [ { :type => "Certification",
                              :source => { :title => "NOCTI" },
                              :title => "Business Financial Management",
                              :id => 845 } ]
          )
        )
      @credentials = Verso::CredentialList.new
    end

    it 'responds to #first' do
      credential = @credentials.first
      credential.title.should eq("Business Financial Management")
      credential.id.should eq(845)
    end

    it 'responds to #last' do
      credential = @credentials.last
      credential.title.should eq("Business Financial Management")
      credential.id.should eq(845)
    end

    it 'responds to #empty?' do
      @credentials.empty?.should eq(false)
    end
  end

  context "search list" do
    before do
      Net::HTTP.
        should_receive(:get).
        with('api.cteresource.org', "/credentials?text=nocti", 80).
        and_return(
          JSON.pretty_generate(
            :credentials => [ { :type => "Certification",
                              :source => { :title => "NOCTI" },
                              :title => "Basket weaving",
                              :id => 855 } ]
          )
        )
      @credentials = Verso::CredentialList.new(:text => 'nocti')
    end

    it 'searches credentials' do
      credential = @credentials.first
      credential.title.should eq("Basket weaving")
      credential.id.should eq(855)
    end
  end

  context "search list with empty string" do
    before do
      Net::HTTP.
        should_receive(:get).
        with('api.cteresource.org', "/credentials", 80).
        and_return(
          JSON.pretty_generate(:credentials => [])
        )
      @credentials = Verso::CredentialList.new(:text => '')
    end

    it 'searches credentials' do
      @credentials.empty?
    end
  end
end
