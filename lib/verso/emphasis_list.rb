module Verso
  # Academic Emphasis List resource
  #
  # A collection of all {Verso::Emphasis} objects.
  #
  # @see http://api.cteresource.org/docs/academics
  #
  # @example Get a list
  #   emphases = Verso::EmphasisList.new # => all of them
  #   emphases.first.title # => "Algebra"
  class EmphasisList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :emphases, :[], :each, :empty?, :last, :length

  private

    def emphases
      @emphases ||= get_attr(:emphases).collect { |em| Emphasis.new(em) }
    end

    def path
      "/academics/"
    end
  end
end
