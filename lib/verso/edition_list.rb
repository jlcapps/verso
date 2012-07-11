module Verso
  class EditionList
    include Enumerable
    include HTTPGet

    def editions
      @editions ||= JSON.parse(http_get('/editions/'))["editions"].
                      collect { |e| OpenStruct.new(e) }
    end

    def each &block
      editions.each &block
    end

    def last
      editions[-1]
    end
  end
end
