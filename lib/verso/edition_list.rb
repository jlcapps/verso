module Verso
  class EditionList < Verso::Base
    include Enumerable
    include HTTPGettable

    def editions
      @editions ||= method_missing(:editions).
                      collect { |e| OpenStruct.new(e) }
    end

    def each &block
      editions.each &block
    end

    def last
      editions[-1]
    end

  private

    def path
      "/editions/"
    end
  end
end
