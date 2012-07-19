module Verso
  class OccupationData
    def initialize(od)
      @raw_od = od.symbolize_nested_keys!
    end

    def cluster
      @cluster ||= Cluster.new(@raw_od[:cluster])
    end

    def occupations
      @occupations ||= @raw_od[:occupations].
        collect { |o| Occupation.new(o) }
    end

    def pathway
      @pathway ||= Pathway.new(@raw_od[:pathway])
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
