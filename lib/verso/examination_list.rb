module Verso
  class ExaminationList
    include Enumerable
    include HTTPGet

    attr_reader :examinations

    def initialize
      @examinations = JSON.parse(http_get("/examinations/"))["examinations"].
        collect { |e| OpenStruct.new(e) }
    end

    def each &block
      examinations.each &block
    end

    def last
      examinations[-1]
    end
  end
end
