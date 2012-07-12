module Verso
  class ProgramAreaList
    include Enumerable
    include HTTPGet

    def program_areas
      @program_areas ||= JSON.parse(
        http_get('/program_areas/')
      )["program_areas"].collect { |pa| ProgramArea.new(pa) }
    end

    def each &block
      program_areas.each &block
    end

    def last
      program_areas[-1]
    end
  end
end
