module Verso
  # Course Resource
  #
  # The chief container of Virginia CTE course data and the *parent of
  # curriculum data.
  #
  # @see http://api.cteresource.org/docs/courses/course
  #
  # @!attribute [r] co_op
  #   @return [Boolean] Is this a co-op course?
  # @!attribute [r] code
  #   @return [String] Course code
  # @!attribute [r] complement
  #   @return [Boolean] Is this a complementary course?
  # @!attribute [r] description
  #   @return [String] HTML-formatted course description
  # @!attribute [r] duration
  #   @return [Fixnum] Course duration in weeks
  # @!attribute [r] edition
  #   @return [String] Edition year
  # @!attribute [r] grade_levels
  #   @return [String] Space-separated list of recommended grade levels
  # @!attribute [r] hours
  #   @return [nil,Fixnum] Course hours
  # @!attribute [r] hs_credit_in_ms
  #   @return [Boolean] High school credit in middle school?
  # @!attribute [r] osha_exempt
  #   @return [Boolean] Is this course exempt from the OSHA memo?
  # @!attribute [r] related_resources
  #   @return [Array] Array of strings specifying related resources
  #   @see http://api.cteresource.org/docs/courses/course
  # @!attribute [r] title
  #   @return [String] Course title
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [String] :code Course code *Required*
  #   @option attrs [String] :edition Edition year *Required*
  class Course < Verso::Base
    include HTTPGettable
    attr_reader :co_op, :code, :complement, :description, :duration,
      :edition, :grade_levels, :hours, :hs_credit_in_ms, :osha_exempt,
      :related_resources, :title
    alias co_op? co_op
    alias complement? complement
    alias hs_credit_in_ms? hs_credit_in_ms
    alias osha_exempt? osha_exempt

    # @return [Array] Collection of certification {Verso::Credential} objects
    def certifications
      @certfications ||= credentials.select { |c| c.type == "Certification" }
    end

    # @return [Array] Collection of {Verso::Credential} objects
    def credentials
      @credentials ||= get_attr(:credentials).collect { |c| Credential.new(c) }
    end

    # @return [Verso::TaskList] TaskList is a collection of {Verso::DutyArea}
    #   objects.
    def duty_areas
      @duty_areas ||= TaskList.new(:code => code, :edition => edition)
    end
    alias tasklist duty_areas

    # @return [Verso::ExtrasList]
    def extras
      @extras ||= if related_resources.include?("extras")
                    ExtrasList.new(:code => code, :edition => edition)
                  else
                    []
                  end
    end

    # @return [Verso:Frontmatter]
    def frontmatter
      @frontmatter ||= if self.related_resources.include?("frontmatter")
                         Frontmatter.new("code" => code, "edition" => edition)
                       else
                         nil
                       end
    end

    # @return [Boolean] Is this a middle school course?
    def is_ms?
      grade_levels.split.first.to_i < 9
    end

    # @return [Boolean] is this a high school course?
    def is_hs?
      grade_levels.split.last.to_i > 8
    end

    # @return [Array] Colection of license {Verso::Credential} objects
    def licenses
      @licenses ||= credentials.select { |c| c.type == "License" }
    end

    # @return [Array] Collection of prerequisite {Verso::Course} objects
    def prerequisite_courses
      @prerequisites ||= get_attr(:prerequisite_courses).
                           collect { |c| Course.new(c) }
    end
    alias prerequisites prerequisite_courses

    # @return [Array] Collection of {Verso::OccupationData} objects
    def occupation_data
      @occupation_data ||= get_attr(:occupation_data).
        collect { |od| OccupationData.new(od) }
    end

    # @return [Array] Collection of related {Verso::Course} objects
    #   forming sequences with this course.
    def related_courses
      @related_courses ||= get_attr(:related_courses).
                             collect { |c| Course.new(c) }
    end

    # @return [Verso::StandardsList] Standards bodies correlated to this
    #   course's tasks.
    def standards
      @standards ||= StandardsList.from_course(self)
    end

    # Fetch a complete task given a task id.
    #
    # @param [Fixnum] tid The task id
    # @return [Verso::Task]
    def task(tid)
      @tasks ||= {}
      @tasks[tid] ||= Task.new("code" => code, "edition" => edition,
                               "id" => tid)
    end

  private

    def path
      "/courses/#{code},#{edition}"
    end
  end
end
