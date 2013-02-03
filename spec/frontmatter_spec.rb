require 'spec_helper'

describe Verso::Frontmatter, :vcr do

  before(:each) do
    @fm = Verso::Frontmatter.new(:code => "6321",
                                 :edition => Verso::EditionList.new.last.year)
  end

  describe '#acknowledgments_text' do
    it 'responds' do
      @fm.should respond_to(:acknowledgments_text)
    end

    it 'is a String' do
      @fm.acknowledgments_text.should be_a(String)
    end

    it 'is HTML' do
      @fm.acknowledgments_text.should match(/<\/.+>/)
    end
  end

  describe '#attribution_block' do
    it 'responds' do
      @fm.should respond_to(:attribution_block)
    end

    it 'is a String' do
      @fm.attribution_block.should be_a(String)
    end

    it 'is HTML' do
      @fm.attribution_block.should match(/<\/.+>/)
    end
  end

  describe '#code' do
    it 'responds' do
      @fm.should respond_to(:code)
    end

    it 'is a String' do
      @fm.code.should be_a(String)
    end

    it 'looks like a code' do
      @fm.code.should match(/\d{4}/)
    end
  end

  describe '#copyright_year' do
    it 'responds' do
      @fm.should respond_to(:copyright_year)
    end

    it 'is a String' do
      @fm.copyright_year.should be_a(String)
    end

    it 'looks like a year' do
      @fm.copyright_year.should match(/^2\d{3}$/)
    end
  end

  describe 'developed_by' do
    it 'responds' do
      @fm.should respond_to(:developed_by)
    end

    it 'is a String' do
      @fm.developed_by.should be_a(String)
    end

    it 'is HTML' do
      @fm.developed_by.should match(/<\/.+>/)
    end
  end

  describe '#developed_for' do
    it 'responds' do
      @fm.should respond_to(:developed_for)
    end

    it 'is a String' do
      @fm.developed_for.should be_a(String)
    end

    it 'is HTML' do
      @fm.developed_for.should match(/<\/.+>/)
    end
  end

  describe '#edition' do
    it 'responds' do
      @fm.should respond_to(:edition)
    end

    it 'is a String' do
      @fm.edition.should be_a(String)
    end

    it 'looks like a year' do
      @fm.edition.should match(/^2\d{3}$/)
    end
  end

  describe '#foreword_text' do
    it 'responds' do
      @fm.should respond_to(:foreword_text)
    end

    it 'is a String' do
      @fm.foreword_text.should be_a(String)
    end

    it 'is HTML' do
      @fm.foreword_text.should match(/<\/.+>/)
    end
  end

  describe '#introduction_text' do
    it 'responds' do
      @fm.should respond_to(:introduction_text)
    end

    it 'is a String' do
      @fm.introduction_text.should be_a(String)
    end
  end

  describe '#notice_block' do
    it 'responds' do
      @fm.should respond_to(:notice_block)
    end

    it 'is a String' do
      @fm.notice_block.should be_a(String)
    end

    it 'is HTML' do
      @fm.notice_block.should match(/<\/.+>/)
    end
  end
end
