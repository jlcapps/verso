module Verso
  class ProgramAreaList < Verso::Base
    include Enumerable
    include HTTPGettable

    def program_areas
      @program_areas ||= get_attr(:program_areas).
                           collect { |pa| ProgramArea.new(pa) }
    end

    def each &block
      program_areas.each &block
    end

    def last
      program_areas[-1]
    end

  private

    def path
      "/program_areas/"
    end
  end
end
