module Verso
  class ProgramArea < Verso::Base
    include HTTPGettable
    attr_reader :deprecated, :official, :section_overview, :title, :version_date

    def courses
      @courses ||= CourseList.new(:program_area => slug.gsub('-', ' ')).
                     sort_by { |c| c.title + c.edition }.
                     uniq { |c| c.code + c.edition }
    end

    def description
      ""
    end

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
