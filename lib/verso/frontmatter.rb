module Verso
  # Frontmatter resource
  #
  # Frontmatter for {Verso::Course} framework.
  #
  # @see http://api.cteresource.org/docs/courses/course/frontmatter
  #
  # @!attribute [r] acknowledgments_text
  #   @return [String] HTML-formatted acknowledgments
  # @!attribute [r] attribution_block
  #   @return [String] HTML-formatted attribution
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] copyright_year
  #   @return [String] Copyright year
  # @!attribute [r] developed_by
  #   @return [String] HTML-formatted developed-by text
  # @!attribute [r] developed_for
  #   @return [String] HTML-formatted developed-for text
  # @!attribute [r] edition
  #   @return [String] Edition year
  # @!attribute [r] foreword_text
  #   @return [String] HTML-formatted foreword
  # @!attribute [r] introduction_text
  #   @return [String] HTML-formatted introduction_text
  # @!attribute [r] notice_block
  #   @return [String] HTML formatted notice_block
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  class Frontmatter < Verso::Base
    include HTTPGettable
    attr_reader :acknowledgments_text, :attribution_block, :code,
      :copyright_year, :developed_by, :developed_for, :edition,
      :foreword_text, :introduction_text, :notice_block

  private

    def fetch
      super[:frontmatter]
    end

    def path
      "/courses/#{code},#{edition}/frontmatter"
    end
  end
end
