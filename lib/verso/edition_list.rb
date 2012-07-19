module Verso
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
