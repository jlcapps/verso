module Verso
  class ClusterList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :clusters, :[], :each, :empty?, :last, :length

  private

    def clusters
      @clusters ||= method_missing(:clusters).collect { |c| Cluster.new(c) }
    end

    def path
      "/clusters/"
    end
  end
end
