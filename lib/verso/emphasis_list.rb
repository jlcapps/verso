module Verso
  class EmphasisList
    include Enumerable
    include HTTPGet

    def emphases
      @emphases ||= JSON.parse(http_get('/academics/'))["emphases"].
        collect { |em| Emphasis.new(em) }
    end

    def each &block
      emphases.each &block
    end

    def last
      emphases[-1]
    end
  end
end
