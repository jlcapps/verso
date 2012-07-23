module Verso
  # Program Area List resource
  #
  # A collection of {Verso::ProgramArea} objects.
  #
  # @see http://api.cteresource.org/docs/program_areas
  class ProgramAreaList < Verso::Base
    include Enumerable
    include HTTPGettable
    extend Forwardable
    def_delegators :program_areas, :[], :each, :empty?, :last, :length

  private

    def program_areas
      @program_areas ||= get_attr(:program_areas).
                           collect { |pa| ProgramArea.new(pa) }
    end

    def path
      "/program_areas/"
    end
  end
end
