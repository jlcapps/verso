module Verso
  # Pathway Resource
  #
  # @see http://api.cteresource.org/docs/pathways/pathway
  # @see http://www.careertech.org/career-clusters/clusters-occupations.html
  #
  # @!attribute [r] description
  #   @return [String] HTML-formatted Pathway description
  # @!attribute [r] id
  #   @return [Fixnum] Pathway id
  # @!attribute [r] title
  #   @return [String] Pathway title
  #
  # @overload initialize(attrs={})
  #   @note Any attributes may be set upon instantiation, using Options Hash.
  #     The following are required:
  #   @option attrs [Fixnum] :id Pathway id *Required*
  class Pathway < Verso::Base
    include HTTPGettable
    include Sluggable
    attr_reader :description, :id, :title

    # @return [Verso::Cluster] Parent Cluster
    def cluster
      @cluster ||= Cluster.new(get_attr(:cluster))
    end

    # @return [Array] Children {Verso::Occupation} objects
    def occupations
      @occupations ||= get_attr(:occupations).
        collect { |o| Occupation.new(o) }
    end

  private

    def fetch
      super[:pathway]
    end

    def path
      "/pathways/#{id}"
    end
  end
end
