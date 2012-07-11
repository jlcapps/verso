module Verso
  class CategoryList
    include Enumerable
    include HTTPGet

    def program_areas
      JSON.parse(http_get('/program_areas/'))["program_areas"].
        reject { |pa| pa["deprecated"] }.
        reject { |pa| pa["title"] == "Academic" }.
        collect { |pa| ProgramArea.new(pa) }
    end

    def clusters
      JSON.parse(http_get('/clusters/'))["clusters"].
        collect { |c| Cluster.new(c) }
    end

    def categories
      @categories ||= program_areas + clusters
    end

    def each &block
      categories.each &block
    end

    def last
      categories[-1]
    end
  end
end
