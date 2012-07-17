module Verso
  class Course < Verso::Base
    include HTTPGet
    attr_reader :co_op, :code, :complement, :description, :duration,
      :edition, :grade_levels, :hours, :hs_credit_in_ms, :osha_exempt,
      :related_resources, :title
    alias co_op? co_op
    alias complement? complement
    alias hs_credit_in_ms? hs_credit_in_ms
    alias osha_exempt? osha_exempt

    def task(tid)
      @tasks ||= {}
      @tasks[tid] ||= Task.new("code" => code, "edition" => edition,
                               "id" => tid)
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

    def prerequisite_courses
      @prerequisites ||= method_missing(:prerequisite_courses).
        collect { |c| Course.new(c) }
    end
    alias prerequisites prerequisite_courses

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

  private

    def path
      "/courses/#{code},#{edition}"
    end
  end
end
