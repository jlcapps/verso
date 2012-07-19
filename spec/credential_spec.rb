require 'spec_helper'

describe Verso::Credential do
  use_vcr_cassette :record => :new_episodes
  before do
    @credential = Verso::CredentialList.new.last
  end

  describe '#admin_notes' do
    it 'responds' do
      @credential.should respond_to(:admin_notes)
    end

    it 'is a String' do
      @credential.admin_notes.should be_a(String)
    end

    it 'looks like HTML' do
      @credential.admin_notes.should match(/<\/.+>/)
    end
  end

  describe '#amt_seal' do
    it 'responds' do
      @credential.should respond_to(:amt_seal)
    end

    it 'is a Boolean' do
      @credential.amt_seal.to_s.should match(/true|false/)
    end
  end

  describe '#amt_seal?' do
    it 'responds' do
      @credential.should respond_to(:amt_seal?)
    end

    it 'is a Boolean' do
      @credential.amt_seal?.to_s.should match(/true|false/)
    end
  end

  describe '#contact_info' do
    it 'responds' do
      @credential.should respond_to(:contact_info)
    end

    it 'is a String' do
      @credential.contact_info.should be_a(String)
    end

    it 'looks like HTML' do
      @credential.contact_info.should match(/<\/.+>/)
    end
  end

  describe '#contacts' do
    it 'responds' do
      @credential.should respond_to(:contacts)
    end

    it 'is an Array' do
      @credential.contacts.should be_a(Array)
    end

    it 'each item is an OpenStruct object' do
      @credential.contacts.first.should be_a(OpenStruct)
    end

    it 'each contact has a name' do
      @credential.contacts.first.name.should be_a(String)
    end

    it 'each contact has an email' do
      @credential.contacts.first.email.should match(/.+@doe.virginia.gov/)
    end

    it 'each contact has a phone' do
      @credential.contacts.first.phone.should match(/804-\d{3}-\d{4}/)
    end
  end

  describe '#contractor_name' do
    it 'responds' do
      @credential.should respond_to(:contractor_name)
    end

    it 'is a String' do
      @credential.contractor_name.should be_a(String)
    end

    it 'is still a String if the API sends nil' do
      cred = Verso::Credential.new(:contractor_name => nil)
      cred.contractor_name.should be_a(String)
    end
  end

  describe '#cost' do
    it 'responds' do
      @credential.should respond_to(:cost)
    end

    it 'is a String' do
      @credential.cost.should be_a(String)
    end
  end

  describe '#cte_seal' do
    it 'responds' do
      @credential.should respond_to(:cte_seal)
    end

    it 'is a Boolean' do
      @credential.cte_seal.to_s.should match(/true|false/)
    end
  end

  describe '#cte_seal?' do
    it 'responds' do
      @credential.should respond_to(:cte_seal?)
    end

    it 'is a Boolean' do
      @credential.cte_seal?.to_s.should match(/true|false/)
    end
  end

  describe '#description' do
    it 'responds' do
      @credential.should respond_to(:description)
    end

    it 'is a String' do
      @credential.description.should be_a(String)
    end
  end

  describe '#details' do
    it 'responds' do
      @credential.should respond_to(:details)
    end

    it 'is a String' do
      @credential.details.should be_a(String)
    end

    it 'looks like HTML' do
      @credential.details.should match(/<\/.+>/)
    end
  end

  describe '#has_ancestor' do
    it 'responds' do
      @credential.should respond_to(:has_ancestor)
    end

    it 'is a Boolean' do
      @credential.has_ancestor.to_s.should match(/true|false/)
    end
  end

  describe '#has_ancestor?' do
    it 'responds' do
      @credential.should respond_to(:has_ancestor?)
    end

    it 'is a Boolean' do
      @credential.has_ancestor?.to_s.should match(/true|false/)
    end
  end

  describe '#how_to_earn_it' do
    it 'responds' do
      @credential.should respond_to(:how_to_earn_it)
    end

    it 'is a String' do
      @credential.how_to_earn_it.should be_a(String)
    end
  end

  describe '#id' do
    it 'responds' do
      @credential.should respond_to(:id)
    end

    it 'is a Fixnum' do
      @credential.id.should be_a(Fixnum)
    end

    it 'is not the same as #object_id' do
      @credential.id.should_not == @credential.object_id
    end
  end

  describe '#items' do
    it 'responds' do
      @credential.should respond_to(:items)
    end

    it 'is a String' do
      @credential.items.should be_a(String)
    end
  end

  describe '#pretest' do
    it 'responds' do
      @credential.should respond_to(:pretest)
    end

    it 'is a Boolean or nil' do
      @credential.pretest.should_not be_a(String)
      @credential.pretest.to_s.should match(/^$|true|false/)
    end

    it 'no really it might be nil' do
      cred = Verso::Credential.new(:pretest => nil)
      cred.pretest.to_s.should match(/^$|true|false/)
      cred = Verso::Credential.new(:pretest => "foo")
      cred.pretest.to_s.should_not match(/^$|true|false/)
    end
  end

  describe '#proctor' do
    it 'responds' do
      @credential.should respond_to(:proctor)
    end

    it 'is a String' do
      @credential.proctor.should be_a(String)
    end
  end

  describe '#program_area' do
    it 'responds' do
      @credential.should respond_to(:program_area)
    end

    it 'is a String' do
      @credential.program_area.should be_a(String)
    end
  end

  describe '#related_courses' do
    it 'responds' do
      @credential.should respond_to(:related_courses)
    end

    it 'is an Array' do
      @credential.related_courses.should be_a(Array)
    end

    it 'is an Array of Verso::Course objects' do
      @credential.related_courses.first.should be_a(Verso::Course)
    end
  end

  describe '#retired' do
    it 'responds' do
      @credential.should respond_to(:retired)
    end

    it 'is a Boolean' do
      @credential.retired.to_s.should match(/true|false/)
    end
  end

  describe '#retired?' do
    it 'responds' do
      @credential.should respond_to(:retired?)
    end

    it 'is a Boolean' do
      @credential.retired?.to_s.should match(/true|false/)
    end
  end

  describe '#site' do
    it 'responds' do
      @credential.should respond_to(:site)
    end

    it 'is a String' do
      @credential.site.should be_a(String)
    end
  end

  describe '#source' do
    it 'responds' do
      @credential.should respond_to(:source)
    end

    it 'is an OpenStruct object' do
      @credential.source.should be_a(OpenStruct)
    end

    it 'has a title' do
      @credential.source.title.should be_a(String)
    end

    it 'has a url' do
      @credential.source.url.should match(/http:\/\/.+/)
    end

    it 'has HTML-formatted contact_info' do
      @credential.source.contact_info.should match(/<\/.+>/)
    end
  end

  describe '#time' do
    it 'responds' do
      @credential.should respond_to(:time)
    end

    it 'is a String' do
      @credential.time.should be_a(String)
    end
  end

  describe '#type' do
    it 'responds' do
      @credential.should respond_to(:type)
    end

    it 'is a String' do
      @credential.type.should be_a(String)
    end

    it "is either 'Certification' or 'License'" do
      @credential.type.should match(/Certification|License/)
    end
  end

  describe '#title' do
    it 'responds' do
      @credential.should respond_to(:title)
    end

    it 'is a String' do
      @credential.title.should be_a(String)
    end
  end

  describe '#verified_credit' do
    it 'responds' do
      @credential.should respond_to(:verified_credit)
    end

    it 'is a Boolean' do
      @credential.verified_credit.to_s.should match(/true|false/)
    end
  end

  describe '#verified_credit?' do
    it 'responds' do
      @credential.should respond_to(:verified_credit?)
    end

    it 'is a Boolean' do
      @credential.verified_credit?.to_s.should match(/true|false/)
    end
  end
end
