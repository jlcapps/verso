module Verso
  # Occupation list resource
  #
  # Search {Verso::Occupation} objects using free text. Result is a collection
  # of {Verso::OccupationData} objects containing relevant {Verso::Occupation}
  # objects.
  #
  # @see http://api.cteresource.org/docs/occupations
  #
  # @example Search by free text
  #   ods = Verso::OccupationList.new(:text => "golf") # => golf-related ODs
  #
  # @overload initialize(attrs={})
  #   @option attrs [String] :text Free text
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
