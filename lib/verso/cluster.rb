module Verso
  # Career Cluster Resource
  #
  # @see http://api.cteresource.org/docs/clusters/cluster
  # @see http://www.careertech.org/career-clusters/glance/clusters.html
  #
  # @!attribute [r] code
  #   @return [String] Cluster code
  # @!attribute [r] description
  #   @return [String] HTML-formatted Cluster description
  # @!attribute [r] id
  #   @return [Fixnum] Cluster id
  # @!attribute [r] postsecondary_info
  #   @return [String] HTML-formatted postsecondary preparation info
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [Fixnum] :id Cluster id *Required*
  class Cluster < Verso::Base
    include HTTPGettable
    attr_reader :code, :description, :id, :postsecondary_info

    # Return VDOE Cluster contact. The contact will respond to #name, #email,
    # and #phone, returning Strings.
    #
    # @return [OpenStruct]
    def contact
      @contact ||= OpenStruct.new(get_attr(:contact))
    end

    # Courses related to the Cluster
    #
    # @return [Verso::CourseList]
    def courses
      @courses ||= CourseList.new(:cluster => slug.gsub('-', ' ')).
                     sort_by { |c| c.title + c.edition }.
                     uniq { |c| c.code + c.edition }
    end

    # The Cluster's Pathways
    #
    # @see http://www.careertech.org/career-clusters/clusters-occupations.html
    # @see Verso::Pathway
    #
    # @return [Array]
    def pathways
      @pathways ||= get_attr(:pathways).
        collect { |p| Pathway.new(p) }
    end

    # @return [String] parameterized title
    def slug
      title.parameterize
    end

    # @return [String] Cluster title
    def title
      @title ||= attrs[:title] || attrs[:cluster][:title]
    end

  private

    def fetch
      super[:cluster]
    end

    # @return [String] URI for Cluster resource
    def path
      "/clusters/#{id}"
    end
  end
end
