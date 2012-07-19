module Verso
  # Edition List resource
  #
  # A collection of Edition proxies that respond to #year, returning a string
  # year like '2012'.
  #
  # @example Get a list
  #   editions = Verso::EditionList.new
  #   editions.first.year => # "2012"
  #
  class EditionList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :editions, :[], :each, :empty?, :last, :length

  private

    def editions
      @editions ||= get_attr(:editions).collect { |e| OpenStruct.new(e) }
    end

    def path
      "/editions/"
    end
  end
end
