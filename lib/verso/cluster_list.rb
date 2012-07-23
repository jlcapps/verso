module Verso
  # Career Cluster List Resource
  #
  # A collection of {Verso::Cluster} objects
  #
  # @see http://api.cteresource.org/docs/clusters
  # @see http://www.careertech.org/career-clusters/glance/clusters.html
  class ClusterList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :clusters, :[], :each, :empty?, :last, :length

  private

    def clusters
      @clusters ||= get_attr(:clusters).collect { |c| Cluster.new(c) }
    end

    def path
      "/clusters/"
    end
  end
end
