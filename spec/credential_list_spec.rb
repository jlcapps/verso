require 'spec_helper'

describe Verso::CredentialList do
  use_vcr_cassette :record => :new_episodes
  describe 'array-like behavior' do
    before(:each) do
      @credentials = Verso::CredentialList.new
    end

    describe '#[]' do
      it 'responds' do
        @credentials.should respond_to(:[])
      end

      it 'gets a Verso::Credential object' do
        @credentials[10].should be_a(Verso::Credential)
      end
    end

    describe '#each' do
      it 'responds' do
        @credentials.should respond_to(:each)
      end

      it 'yields' do
        expect { |b| @credentials.each("foo", &b).to yield_control }
      end

      it 'yields Verso::Credential objects' do
        @credentials.each { |c| c.should be_a(Verso::Credential) }
      end
    end

    describe '#empty?' do
      it 'responds' do
        @credentials.should respond_to(:empty?)
      end

      it 'is not empty' do
        @credentials.should_not be_empty
      end
    end

    describe '#last' do
      it 'responds' do
        @credentials.should respond_to(:last)
      end

      it 'is a Verso::Credential object' do
        @credentials.last.should be_a(Verso::Credential)
      end
    end

    describe '#length' do
      it 'responds' do
        @credentials.should respond_to(:length)
      end

      it 'is a Fixnum' do
        @credentials.length.should be_a(Fixnum)
      end
    end

    describe '#first' do
      it 'responds' do
        @credentials.should respond_to(:first)
      end

      it 'is a Verso::Credential object' do
        @credentials.first.should be_a(Verso::Credential)
      end
    end

    describe '#count' do
      it 'responds' do
        @credentials.should respond_to(:count)
      end

      it 'is a Fixnum' do
        @credentials.count.should be_a(Fixnum)
      end
    end
  end

  describe 'search' do
    before(:each) do
      @credentials = Verso::CredentialList.new(:text => 'nocti')
    end

    it 'is a collection of Verso::Credential objects' do
      @credentials.first.should be_a(Verso::Credential)
    end

    it 'is related to the search term' do
      @credentials.first.source.title.should match (/NOCTI/)
    end
  end

  describe 'empty search' do
    it 'gives you everything' do
      Verso::CredentialList.new(:text => '').count.should eq(
        Verso::CredentialList.new.count
      )
    end
  end
end
