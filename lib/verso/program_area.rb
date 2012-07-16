module Verso
  class ProgramArea
    include HTTPGet

    def initialize(raw_category)
      @raw_program_area = raw_category.symbolize_nested_keys!
    end

    def method_missing(mname)
      if @raw_program_area[mname].nil?
        @raw_program_area.merge!(
          JSON.parse(http_get("/program_areas/"))["program_areas"].
                       find { |c| c["title"] == @raw_program_area[:title] }.
                       symbolize_nested_keys!
          )
      end
      @raw_program_area[mname]
    end

    def description
      ""
    end

    def courses
      @courses ||= CourseList.new(:program_area => slug.gsub('-', ' ')).
                     sort_by { |c| c.title + c.edition }.
                     uniq { |c| c.code + c.edition }
    end

    def slug
      # swiped from ActiveSupport::Inflector
      parameterized_string = @raw_program_area[:title].dup
      parameterized_string.gsub!(/[^a-z0-9\-_]+/i, '-')
      re_sep = Regexp.escape('-')
      parameterized_string.gsub!(/#{re_sep}{2,}/, '-')
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
      parameterized_string.downcase
    end
  end
end
