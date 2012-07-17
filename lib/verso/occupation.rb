module Verso
  class Occupation
    include HTTPGettable

    def initialize(raw_occupation)
      @raw_occupation = raw_occupation.symbolize_nested_keys!
    end

    def method_missing(mname)
      if @raw_occupation[mname].nil?
        @raw_occupation = JSON.parse(
          http_get("/occupations/#{id}")
        )["occupation"].symbolize_nested_keys!
      end
      @raw_occupation[mname]
    end

    def related_courses
      @related_courses ||= method_missing(:related_courses).
        collect { |c| Course.new(c) }
    end

    def pathway
      @pathway ||= Pathway.new(method_missing(:pathway))
    end
  end
end
