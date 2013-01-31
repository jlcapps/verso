module Verso
  # Occupation Data
  #
  # A list of occupations grouped by the Cluster/Pathway that contains them.
  # Occupation Data is not an independent resource. It is a component of
  # {Verso::OccupationList}, {Verso::Course}, and {Verso::Emphasis}.
  #
  # @see http://api.cteresource.org/docs/academics/emphasis
  # @see http://api.cteresource.org/docs/courses/course
  # @see http://api.cteresource.org/docs/occupations
  #
  # @note Because an OccupationData object is created for you by other
  #   resources you should never need to instantiate one yourself.
  class OccupationData < Verso::Base
    # @return [Verso::Cluster] Cluster (grandparent of occupations)
    def cluster
      @cluster ||= Cluster.new(get_attr(:cluster))
    end

    # @return [Array] Collection of {Verso::Occupation} objects
    def occupations
      @occupations ||= get_attr(:occupations).collect { |o| Occupation.new(o) }
    end

    # @return [Verso::Pathway] Pathway (parent of occupations)
    def pathway
      @pathway ||= Pathway.new(get_attr(:pathway))
    end

    # Find OccupationData by cluster, pathway, and occupation slugs
    #
    # @example Find an OccupationData for an occupation
    #   od = Verso::OccupationData.find_by_slugs('finance', 'accounting', 'cost-analyst')
    #   od.occupations.count # => 1
    #   od.occupations.first.title # => 'Cost Analyst'
    #
    # @param [String] cslug Cluster slug
    # @param [String] pslug Pathway slug
    # @param [String] slug Occupation slug
    # @return [Verso::OccupationData,nil] Containing only one Occupation
    def self.find_by_slugs(cslug, pslug, slug)
      cluster = ClusterList.new.find { |c| c.slug== cslug }
      pathway = cluster.pathways.find { |p| p.slug == pslug }
      occupation = pathway.occupations.find { |o| o.slug == slug }
      OccupationData.new(
        { :cluster => { :title => cluster.title },
          :pathway => { :title => pathway.title },
          :occupations => [{ :title => occupation.title }] }
      )
    end
  end
end
