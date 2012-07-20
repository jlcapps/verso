module Verso
  class OccupationList < Verso::Base
    include Enumerable
    include HTTPGettable

    def occupations
      return [] if attrs[:text].to_s.empty?
      @occupations ||= get_attr(:occupation_data).
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

  private

    def path
      @path ||= Addressable::URI.new(:path => '/occupations',
                                     :query_values => attrs).request_uri
    end
  end
end
