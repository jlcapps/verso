module Verso
  class EmphasisList < Verso::Base
    include Enumerable
    include HTTPGettable

    def emphases
      @emphases ||= get_attr(:emphases).collect { |em| Emphasis.new(em) }
    end

    def each &block
      emphases.each &block
    end

    def last
      emphases[-1]
    end

  private

    def path
      "/academics/"
    end
  end
end
