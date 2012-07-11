module Verso
  class Emphasis
    include HTTPGet

    def initialize(raw_emphasis)
      @raw_emphasis = raw_emphasis
    end

    def method_missing(mname)
      if !@raw_emphasis.has_key?(mname.to_s)
        @raw_emphasis = JSON.parse(http_get("/academics/#{id}"))["emphasis"]
      end
      @raw_emphasis[mname.to_s]
    end

    def occupation_data
      @occupation_data ||= method_missing(:occupation_data).
        collect { |od| OccupationData.new(od) }
    end
  end
end
