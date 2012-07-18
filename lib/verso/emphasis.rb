module Verso
  class Emphasis < Verso::Base
    include HTTPGettable
    attr_reader :id, :title

    def occupation_data
      @occupation_data ||= get_attr(:occupation_data).
        collect { |od| OccupationData.new(od) }
    end

  private

    def fetch
      super[:emphasis]
    end

    def path
      "/academics/#{id}"
    end
  end
end
