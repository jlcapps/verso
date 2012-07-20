module Verso
  class OccupationList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :occupations, :[], :each, :empty?, :last, :length

  private

    def occupations
      return [] if attrs[:text].to_s.empty?
      @occupations ||= get_attr(:occupation_data).
          collect { |o| OccupationData.new(o) }.
          sort_by { |o| [o.cluster.title, o.pathway.title] }
    end

    def path
      @path ||= Addressable::URI.new(:path => '/occupations',
                                     :query_values => attrs).request_uri
    end
  end
end
