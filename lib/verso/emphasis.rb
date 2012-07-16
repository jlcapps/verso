module Verso
  class Emphasis
    include HTTPGet

    def initialize(raw_emphasis)
      @raw_emphasis = raw_emphasis.symbolize_nested_keys!
    end

    def method_missing(mname)
      if !@raw_emphasis.has_key?(mname)
        @raw_emphasis = JSON.parse(http_get("/academics/#{id}"))["emphasis"].
          symbolize_nested_keys!
      end
      @raw_emphasis[mname]
    end

    def occupation_data
      @occupation_data ||= method_missing(:occupation_data).
        collect { |od| OccupationData.new(od) }
    end
  end
end
