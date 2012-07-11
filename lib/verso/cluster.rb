module Verso
  class Cluster
    include HTTPGet

    def initialize(opts)
      @raw_cluster = opts
    end

    def method_missing(mname)
      if !@raw_cluster.has_key?(mname.to_s)
        @raw_cluster.merge!(JSON.parse(http_get("/clusters/#{id}"))["cluster"])
      end
      @raw_cluster[mname.to_s]
    end

    def id
      @raw_cluster["id"]
    end

    def title
      @title ||= @raw_cluster["title"] || @raw_cluster["cluster"]["title"]
    end

    def contact
      @contact ||= OpenStruct.new(method_missing(:contact))
    end

    def slug
      @raw_cluster["title"].parameterize
    end

    def pathways
      @pathways ||= method_missing(:pathways).
        collect { |p| Pathway.new(p) }
    end

    def courses
      @courses ||= CourseList.new(:cluster => slug.gsub('-', ' ')).
                     sort_by { |c| c.title + c.edition }.
                     uniq { |c| c.code + c.edition }
    end
  end
end
