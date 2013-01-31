module Verso
  # Occupation resource
  #
  # An occupation is contained by a Pathway
  #
  # @see http://api.cteresource.org/docs/occupations/occupation
  # @see http://www.careertech.org/career-clusters/clusters-occupations.html
  #
  # @!attribute [r] description
  #   @return [String] HTML-formatted Occupation description
  # @!attribute [r] id
  #   @return [Fixnum] Occupation ID
  # @!attribute [r] preparations
  #   @return [Array] Collection of preparation titles (strings)
  # @!attribute [r] title
  #   @return [String] Occupation title
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [Fixnum] :id Occupation ID *Required*
  class Occupation < Verso::Base
    include HTTPGettable
    include Sluggable
    attr_reader :description, :id, :preparations, :title

    # @return [Verso::Pathway] Pathway that is the parent of this occupation
    def pathway
      @pathway ||= Pathway.new(get_attr(:pathway))
    end

    # @return [Array] Collection of related {Verso::Course} objects
    def related_courses
      @related_courses ||= get_attr(:related_courses).
                             collect { |c| Course.new(c) }
    end

  private

    def fetch
      super[:occupation]
    end

    def path
      "/occupations/#{id}"
    end
  end
end
