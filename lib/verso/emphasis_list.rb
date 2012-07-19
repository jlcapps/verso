module Verso
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
