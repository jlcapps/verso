module Verso
  class Pathway
    include HTTPGet

    def initialize(raw_pathway)
      @raw_pathway = raw_pathway
    end

    def method_missing(mname)
      if @raw_pathway[mname.to_s].nil?
        @raw_pathway = JSON.parse(http_get("/pathways/#{id}"))["pathway"]
      end
      @raw_pathway[mname.to_s]
    end

    def occupations
      @occupations ||= method_missing(:occupations).
        collect { |o| Occupation.new(o) }
    end

    def cluster
      @cluster ||= Cluster.new(method_missing(:cluster))
    end
  end
end
