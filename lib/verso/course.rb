module Verso
  class Course
    include HTTPGet

    def initialize(raw_course)
      @raw_course = raw_course.symbolize_nested_keys!
    end

    def method_missing(mname)
      if !@raw_course.has_key?(mname)
        @raw_course = JSON.parse(http_get("/courses/#{code},#{edition}")).
          symbolize_nested_keys!
      end
      @raw_course.has_key?(mname) ? @raw_course[mname] : super
    end

    def task(tid)
      @tasks ||= {}
      @tasks[tid] ||= Task.new("code" => code, "edition" => edition, "id" => tid)
    end

    def frontmatter
      @frontmatter ||= if self.related_resources.include?("frontmatter")
                         Frontmatter.new("code" => code, "edition" => edition)
                       else
                         nil
                       end
    end

    def duty_areas
      @duty_areas ||= TaskList.new(:code => code, :edition => edition)
    end

    def occupation_data
      @occupation_data ||= method_missing(:occupation_data).
        collect { |od| OccupationData.new(od) }
    end

    def prerequisites
      @prerequisites ||= prerequisite_courses.collect { |c| Course.new(c) }
    end

    def related_courses
      @related_courses ||= method_missing(:related_courses).
                             collect { |c| Course.new(c) }
    end

    def credentials
      @credentials ||= method_missing(:credentials).
                         collect { |c| Credential.new(c) }
    end

    def certifications
      @certfications ||= credentials.select { |c| c.type == "Certification" }
    end

    def licenses
      @licenses ||= credentials.select { |c| c.type == "License" }
    end

    def standards
      @standards ||= if self.related_resources.include?("standards")
                       StandardsList.from_course(self)
                     else
                       StandardsList.new([], self)
                     end
    end

    def is_ms?
      grade_levels.split.first.to_i < 9
    end

    def is_hs?
      grade_levels.split.last.to_i > 8
    end

    def extras
      @extras ||= if related_resources.include?("extras")
                    ExtrasList.new(:code => code, :edition => edition)
                  else
                    []
                  end
    end
  end
end
