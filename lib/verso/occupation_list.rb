module Verso
  class OccupationList
    include Enumerable
    include HTTPGet

    def initialize(raw_query={})
      @q_uri = Addressable::URI.new(
        :path => '/occupations',
        :query_values => raw_query
      )
    end

    def occupations
      @occupations ||= JSON.
        parse(http_get(@q_uri.request_uri))["occupation_data"].
          collect { |o| OccupationData.new(o) }.
          sort_by { |o| [o.cluster.title, o.pathway.title] }
    end

    def each &block
      occupations.each &block
    end

    def last
      occupations[-1]
    end

    def empty?
      occupations.empty?
    end
  end
end
