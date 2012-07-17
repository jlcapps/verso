module Verso
  class Pathway
    include HTTPGettable

    def initialize(raw_pathway)
      @raw_pathway = raw_pathway.symbolize_nested_keys!
    end

    def method_missing(mname)
      if @raw_pathway[mname].nil?
        @raw_pathway = JSON.parse(http_get)["pathway"].symbolize_nested_keys!
      end
      @raw_pathway[mname]
    end

    def occupations
      @occupations ||= method_missing(:occupations).
        collect { |o| Occupation.new(o) }
    end

    def cluster
      @cluster ||= Cluster.new(method_missing(:cluster))
    end

  private

    def path
      "/pathways/#{id}"
    end
  end
end
