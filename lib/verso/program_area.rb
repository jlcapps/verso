module Verso
  # Program Area
  #
  # Contained by {Verso::ProgramAreaList} resource
  #
  # @see http://api.cteresource.org/docs/program_areas
  #
  # @!attribute [r] deprecated
  #   @return [Boolean] Is this Program Area deprecated?
  # @!attribute [r] official
  #   @return [Boolean] Is this an official VDOE Program Area?
  # @!attribute [r] section_overview
  #   @return [String] HTML-formatted text describing Program Area
  # @!attribute [r] title
  #   @return [String] Program Area title
  # @!attribute [r] version_date
  #   @return [String] Date of last update
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [String] :title Program Area title *Required*
  class ProgramArea < Verso::Base
    include HTTPGettable
    attr_reader :deprecated, :official, :section_overview, :title, :version_date

    # @return [Array] Collection of related {Verso::Course} objects
    def courses
      @courses ||= CourseList.new(:program_area => slug.gsub('-', ' ')).
                     sort_by { |c| c.title + c.edition }.
                     uniq { |c| c.code + c.edition }
    end

    # @return [String] Empty string to make consistent interface
    def description
      ""
    end

    # @return [String] Parameterized title
    def slug
      # swiped from ActiveSupport::Inflector
      parameterized_string = title.dup
      parameterized_string.gsub!(/[^a-z0-9\-_]+/i, '-')
      re_sep = Regexp.escape('-')
      parameterized_string.gsub!(/#{re_sep}{2,}/, '-')
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
      parameterized_string.downcase
    end

  private

    def path
      "/program_areas/"
    end

    def fetch
      super[:program_areas].find { |pa| pa[:title] == title }
    end
  end
end
