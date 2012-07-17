module Verso
  class ClusterList
    include Enumerable
    include HTTPGettable

    def clusters
      @clusters ||= JSON.parse(http_get('/clusters/'))["clusters"].
                      collect { |c| Cluster.new(c) }
    end

    def each &block
      clusters.each &block
    end

    def last
      clusters[-1]
    end
  end
end
