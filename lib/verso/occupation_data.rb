module Verso
  class OccupationData < Verso::Base
    def cluster
      @cluster ||= Cluster.new(get_attr(:cluster))
    end

    def occupations
      @occupations ||= get_attr(:occupations).collect { |o| Occupation.new(o) }
    end

    def pathway
      @pathway ||= Pathway.new(get_attr(:pathway))
    end

    def self.find_by_slugs(cslug, pslug, slug)
      cluster = ClusterList.new.find { |c| c.title.parameterize == cslug }
      pathway = cluster.pathways.find { |p| p.title.parameterize == pslug }
      occupation = pathway.occupations.find { |o| o.title.parameterize == slug }
      OccupationData.new(
        { :cluster => { :title => cluster.title },
          :pathway => { :title => pathway.title },
          :occupations => [{ :title => occupation.title }] }
      )
    end
  end
end
